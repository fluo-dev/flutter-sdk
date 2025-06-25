import 'dart:async';

import 'package:fluo/api/api_client.dart';
import 'package:fluo/api/models/api_error.dart';
import 'package:fluo/api/models/partial_session.dart';
import 'package:fluo/l10n/fluo_localizations.dart';
import 'package:fluo/l10n/localized.dart';
import 'package:fluo/widgets/mobile_input.dart';
import 'package:fluo/widgets/single_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterMobileScreen extends StatefulWidget {
  const EnterMobileScreen({
    super.key,
    required this.onBackButtonPressed,
    required this.onMobileSubmitted,
  });

  final VoidCallback onBackButtonPressed;
  final Function(PartialSession partialSession) onMobileSubmitted;

  @override
  State<EnterMobileScreen> createState() => _EnterMobileScreenState();
}

class _EnterMobileScreenState extends State<EnterMobileScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _mobileE164;
  String? _mobileIso2;
  String? _errorText;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _mobileController.addListener(() {
      setState(() {
        _errorText = null;
        // _isMobileValid = do it
      });
    });

    Timer(const Duration(milliseconds: 600), () {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = FluoLocalizations.of(context)!;
    return SingleInputScreen(
      inputTitle: l10n.enterMobile,
      inputWidget: MobileInput(
        controller: _mobileController,
        focusNode: _focusNode,
        onComplete: (mobileE164, mobileIso2) {
          setState(() {
            _mobileE164 = mobileE164;
            _mobileIso2 = mobileIso2;
          });
        },
      ),
      onBackButtonPressed: widget.onBackButtonPressed,
      onNextButtonPressed: _onNext,
      nextButtonEnabled: _mobileE164 != null,
      helperWidget: Text(l10n.enterMobileHelper),
      errorText: _errorText,
      loading: _loading,
    );
  }

  void _onNext() async {
    try {
      setState(() => _loading = true);
      final apiClient = context.read<ApiClient>();
      final partialSession = await apiClient.createPartialSession(
        mobileE164: _mobileE164,
        mobileIso2: _mobileIso2,
        mobileLocal: _mobileController.text,
      );
      widget.onMobileSubmitted(partialSession);
    } on ApiError catch (apiError) {
      setState(() {
        _errorText = Localized.error(context, apiError.message);
      });
    } catch (error) {
      setState(() {
        _errorText = FluoLocalizations.of(context)!.errorUnknown;
      });
    } finally {
      setState(() => _loading = false);
    }
  }
}
