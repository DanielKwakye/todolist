import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// constant colors same in dark and light mode
const kCodeBackgroundColor = Color(0xff1E1E1E);
const kAppFaintBlack = Color(0xff202021);
const kAppGray = Color(0xff666666);
const kAppGrayInLightMode = Color(0xff666666);//Color(0xff666666);
const kAppGrayInDarkMode = Color(0xff999999);//Color(0xff666666);
const kAppLightGray2 = Color(0xffF6F6F6);
const kAppLightGray = Color(0xffF7F7F7);
const kAppWhite = Color(0xffFFFFFF);
const kAppBlue = Color(0xfff04635);
const kAppBlack = Color(0xff101010);
// const kAppBlack = Color(0xff171718);
const kAppCardDarkModeBackground = Color(0xff171718);
// const kAppBlack = Color(0xff13161A);
// const kAppBlack = Color(0xff000000);
// const kAppCardGapsDarkMode = Color(0xff18191A);
const kAppCardGapsDarkMode = Color(0xff101011); // figma
// const kAppCardGapsDarkMode = Color(0xff000000); // figma
const kAppRed = Color(0xffEB5757);
const kAppGreen =  Color(0xff27AE60);
const kOutLine = Color(0xffEDF0F5);
const kAppGold = Color(0xffF2994A);
const kDisabledGrey = Color(0xffC4C4C4);

/// light mode colors
const kLightPrimaryColor = Color(0xffFFFFFF);
const kLightOnPrimaryColor = kAppGrayInLightMode;
const kLightSecondaryColor = kAppBlue;
const kLightOnSecondaryColor = Color(0xffFFFFFF);
const kLightErrorColor = kAppRed;
const kLightOnErrorColor = Color(0xffFFFFFF);
const kLightOutlineColor = kOutLine;

/// dark mode colors
const kDarkPrimaryColor = kAppBlack;
const kDarkOnPrimaryColor = kAppGrayInDarkMode;
const kDarkSecondaryColor = kAppBlue;
const kDarkOnSecondaryColor = kAppWhite;
const kDarkErrorColor = kAppRed;
const kDarkOnErrorColor = Color(0xffFFFFFF);
const kDarkOutlineColor = Color(0xff2C2C2C);
const kTagBlue = Color(0xff81BFE6);
const kTagPurple = Color(0xffA0A5D5);
const kTagLilac = Color(0xffC7A1CB);
const kTagGreen = Color(0xffC1D0B3);
const kPrimaryBlue = Color(0xff13334A);
const kDarkBackGroundColor = Color(0xff1D1D1E);
const kLightBackGroundColor = Color(0xffF6F8FA);
const kAppPurple = Color(0xff8280F7);
const kAppViolet = Color(0xffE580F4);

const kAppLinearGradient = LinearGradient(
    colors: [
      Color(0xfff04635),
      Color(0xfff47a27),
    ]
);


/// UI overlay -> Configure app status bar and android navigation bar here
void setSystemUIOverlays(Brightness brightness) {
  final  systemOverlayStyle = brightness == Brightness.dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
  SystemChrome.setSystemUIOverlayStyle(systemOverlayStyle.copyWith(
    statusBarColor: brightness == Brightness.dark ? kAppBlack : kAppWhite, // android only
    statusBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark, // android only
    systemNavigationBarColor: brightness == Brightness.dark  ? kAppBlack : kAppWhite, // android only
    systemNavigationBarIconBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark // android only
  ));

}


/// using  Google Font quicksand
/// ref -> https://material.io/design/typography/the-type-system.html#type-scale
/// Currently using the quicksand google fonts. We can change the fonts to any google fonts over here

// const _defaultFont = GoogleFonts.quicksandTextTheme;

/// Dark Theme Mode
darkTheme(BuildContext context) => ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.quicksandTextTheme(
        Theme.of(context).textTheme,
    ).copyWith(
        displayLarge: GoogleFonts.quicksand(color: kAppWhite),
        displayMedium: GoogleFonts.quicksand(color: kAppWhite),
        displaySmall: GoogleFonts.quicksand(color: kAppWhite),
        headlineMedium: GoogleFonts.quicksand(color: kAppWhite),
        headlineSmall: GoogleFonts.quicksand(color: kAppWhite),
        titleLarge: GoogleFonts.quicksand(color: kAppWhite),

        bodyMedium: GoogleFonts.quicksand(color: kAppWhite),
        bodySmall: GoogleFonts.quicksand(color: kAppWhite),
        bodyLarge: GoogleFonts.quicksand(color: kAppWhite),
        titleMedium: GoogleFonts.quicksand(color: kAppWhite),
        titleSmall: GoogleFonts.quicksand(color: kDarkOnPrimaryColor),

    ),
    bottomSheetTheme: const BottomSheetThemeData(
      dragHandleColor: kAppWhite
    ),
    // useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: kAppBlack
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textSelectionTheme:  TextSelectionThemeData(
        selectionColor: kAppBlue.withOpacity(0.5),
        selectionHandleColor: kDarkOnPrimaryColor,
        cursorColor: kDarkOnPrimaryColor
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: kDarkOnPrimaryColor,
    ),
    dividerColor: kDarkOutlineColor,
    scaffoldBackgroundColor: kDarkPrimaryColor,
    tabBarTheme:  TabBarTheme(
      labelColor: kAppWhite,
      dividerColor: Colors.transparent,
      labelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w600)
    ), colorScheme: ColorScheme.fromSwatch()
    .copyWith(
  primary: kDarkPrimaryColor,
  onPrimary: kDarkOnPrimaryColor,
  secondary: kDarkSecondaryColor,
  onSecondary: kDarkOnSecondaryColor,
  error: kDarkErrorColor,
  onError: kDarkOnErrorColor,
  background: kAppBlack,
  onBackground: kAppWhite,
  brightness: Brightness.dark,
  outline: kDarkOutlineColor,
  onSurface: kDarkBackGroundColor,

  // surface: const Color(0xff1E2226), // linked in
  surface: const Color(0xff202021), // figma
  // surface: const Color(0xff242526), // facebook dark mode card
).copyWith(background: kDarkPrimaryColor)

);

/// Light Theme Mode
lightTheme(BuildContext context) => ThemeData(

    textTheme: GoogleFonts.quicksandTextTheme(
      Theme.of(context).textTheme,

    ).copyWith(
      displayLarge: GoogleFonts.quicksand(color: kAppFaintBlack),
      displayMedium: GoogleFonts.quicksand(color: kAppFaintBlack),
      displaySmall: GoogleFonts.quicksand(color: kAppFaintBlack),
      headlineMedium: GoogleFonts.quicksand(color: kAppFaintBlack),
      headlineSmall: GoogleFonts.quicksand(color: kAppFaintBlack,),
      titleLarge: GoogleFonts.quicksand(color: kAppFaintBlack),
      bodyMedium: GoogleFonts.quicksand(color: kAppFaintBlack),
      bodySmall: GoogleFonts.quicksand(color: kAppFaintBlack),
      bodyLarge: GoogleFonts.quicksand(color: kAppFaintBlack),
      titleMedium: GoogleFonts.quicksand(color: kAppFaintBlack),
      titleSmall: GoogleFonts.quicksand(color: kLightOnPrimaryColor),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        dragHandleColor: kAppBlack,
    ),
    textSelectionTheme:  TextSelectionThemeData(
        selectionColor: kAppBlue.withOpacity(0.5),
        selectionHandleColor: kLightOnPrimaryColor,
        cursorColor: kLightOnPrimaryColor
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: kLightOnPrimaryColor,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    dividerColor: kLightOutlineColor,
    scaffoldBackgroundColor: kLightPrimaryColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: kAppWhite
    ),
    tabBarTheme: TabBarTheme(
        labelColor: kAppBlack,
        dividerColor: Colors.transparent,
        labelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w600)
    ), colorScheme: ColorScheme.fromSwatch()
    .copyWith(
    primary: kLightPrimaryColor,
    onPrimary: kAppGray,
    secondary: kLightSecondaryColor,
    onSecondary: kLightOnSecondaryColor,
    error: kLightErrorColor,
    onError: kLightOnErrorColor,
    background: kLightPrimaryColor,
    onBackground: kAppBlack,
    brightness: Brightness.light,
    outline: kLightOutlineColor,
    onSurface: kLightBackGroundColor,
    // surface: const Color(0xffF3F2EF)
    surface: const Color(0xfff3f2ef)
  //  // surface: const Color(0xffeef4f4)
  //       // surface: const Color(0xffeaf2fb)
).copyWith(background: kLightPrimaryColor)

);



/// Code view syntax highlighter
const codeViewTheme = {
  'root': TextStyle(backgroundColor: kCodeBackgroundColor, color: Color(0xffDCDCDC)),
  'keyword': TextStyle(color: Color(0xff569CD6)),
  'literal': TextStyle(color: Color(0xff569CD6)),
  'symbol': TextStyle(color: Color(0xff569CD6)),
  'name': TextStyle(color: Color(0xff569CD6)),
  'link': TextStyle(color: Color(0xff569CD6)),
  'built_in': TextStyle(color: Color(0xff4EC9B0)),
  'type': TextStyle(color: Color(0xff4EC9B0)),
  'number': TextStyle(color: Color(0xffB8D7A3)),
  'class': TextStyle(color: Color(0xffB8D7A3)),
  'string': TextStyle(color: Color(0xffD69D85)),
  'meta-string': TextStyle(color: Color(0xffD69D85)),
  'regexp': TextStyle(color: Color(0xff9A5334)),
  'template-tag': TextStyle(color: Color(0xff9A5334)),
  'subst': TextStyle(color: Color(0xffDCDCDC)),
  'function': TextStyle(color: Color(0xffDCDCDC)),
  'title': TextStyle(color: Color(0xffDCDCDC)),
  'params': TextStyle(color: Color(0xffDCDCDC)),
  'formula': TextStyle(color: Color(0xffDCDCDC)),
  'comment': TextStyle(color: Color(0xff57A64A), fontStyle: FontStyle.italic),
  'quote': TextStyle(color: Color(0xff57A64A), fontStyle: FontStyle.italic),
  'doctag': TextStyle(color: Color(0xff608B4E)),
  'meta': TextStyle(color: Color(0xff9B9B9B)),
  'meta-keyword': TextStyle(color: Color(0xff9B9B9B)),
  'tag': TextStyle(color: Color(0xff9B9B9B)),
  'variable': TextStyle(color: Color(0xffBD63C5)),
  'template-variable': TextStyle(color: Color(0xffBD63C5)),
  'attr': TextStyle(color: Color(0xff9CDCFE)),
  'attribute': TextStyle(color: Color(0xff9CDCFE)),
  'builtin-name': TextStyle(color: Color(0xff9CDCFE)),
  'section': TextStyle(color: Color(0xffffd700)),
  'emphasis': TextStyle(fontStyle: FontStyle.italic, color: Color(0xff569CD6)),
  'strong': TextStyle(fontWeight: FontWeight.bold, color: Color(0xff569CD6)),
  'bullet': TextStyle(color: Color(0xffD7BA7D)),
  'selector-tag': TextStyle(color: Color(0xffD7BA7D)),
  'selector-id': TextStyle(color: Color(0xffD7BA7D)),
  'selector-class': TextStyle(color: Color(0xffD7BA7D)),
  'selector-attr': TextStyle(color: Color(0xffD7BA7D)),
  'selector-pseudo': TextStyle(color: Color(0xffD7BA7D)),
  'addition': TextStyle(backgroundColor: Color(0xff144212)),
  'deletion': TextStyle(backgroundColor: Color(0xff660000)),
};
