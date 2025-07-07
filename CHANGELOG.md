## 2.0.1

- Fix crash in enter code screen when clearing an invalid code

## 2.0.0

- Use `Fluo.instance.session.user` to access user data. The JWT access token does not contain user data anymore. The first and last names inputs were not updating the access token correctly, and it would not be right to update the access token every time a user data is changed, so I changed things.

## 1.2.0

- [web only] Fix connect buttons not showing when Google not selected
- Fix left padding on mobile input country flag
- Fix padding and default theme of clear button on text inputs

## 1.0.1

- Improve `FluoTheme` default values for `nextButtonProgressIndicatorSize` and `nextButtonProgressIndicatorColor`

## 1.0.0

- Breaking change on how to use the Fluo SDK
- Review of `FluoTheme` so that you can optionally leverage your defined `ThemeData`
- Simplification of `FluoOnboarding`

## 0.12.1

- Expose `fluo.session` to access session and user info

## 0.12.0

- Mobile auth support (still passwordless)
- Support for 18 languages

## 0.11.0

- Migrate to intl 0.20.2 to improve pub score

## 0.10.0

- Make sure we've got support for macOS
- Improve pub.dev score

## 0.9.0

- Support for Web, super excited about that! See it live at https://fluo-website-demo.netlify.app
- Introducing a dedicated theme `FluoTheme.web()`

## 0.8.1

- The underline decoration of the legal text (terms & privacy) is not set to the color of the text

## 0.8.0

- Support for "Sign in with Apple"
- More customizations for connect buttons in the FluoTheme

## 0.7.0

- Add localizations for German, Portuguese and Brazilian Portuguese

## 0.6.1

- Fixed a bug which was always showing the enter first and last name screens no matter what was selected from the dashboard.

## 0.6.0

- You can now let your users connect with Google sign-in. Set it up on https://dashboard.fluo.dev

## 0.5.0

- Introducing the FluoTheme: customize the look & feel of the fluo sdk.

## 0.4.0

- Don't need the user's last name? This version introduces "dynamic registration steps" allowing you to choose which registration steps you want
- Folder structure has been reviewed to organize screens in flows, structurally speaking

## 0.3.1

- Add `fluo.supabaseSession` to set the session on the supabase flutter client

## 0.3.0

- Breaking change: you have to use this version now
- Resume user registration if not complete
- Add `introBuilder` and `onInitError` in `FluoOnboarding`

## 0.2.1

- Update readme to use a remote url for the screenshot

## 0.2.0

- Change the entrypoint with a much simpler approach: the FluoOnboarding component

## 0.1.4

- Send the language to the server to send emails in different languages
- Ensure generated localization files are correctly formatted

## 0.1.3

- Migrate to flutter_inappwebview to support more platforms

## 0.1.2

- Make userProfileComplete required on the session model

## 0.1.1

- Small modifications to look better on pub.dev

## 0.1.0

- Initial release of fluo sdk
