import 'package:artista_config/artista_config.dart';
import 'package:flutter/material.dart';

class ArtistaButton extends StatelessWidget {
  final Function()? onPressed;
  late final ButtonType? buttonType;
  final ButtonSize buttonSize;
  final ButtonColor buttonColor;
  final bool? isFullWidth;
  final Widget child;

  ArtistaButton({
    super.key,
    this.onPressed,
    required this.buttonSize,
    required this.buttonColor,
    this.isFullWidth = false,
    required this.child,
  }) {
    try {
      initializeArtista();
    } catch (e) {}
    buttonType = ButtonType.elevated;
  }

  ArtistaButton.text({
    super.key,
    this.onPressed,
    required this.buttonSize,
    required this.buttonColor,
    this.isFullWidth = false,
    required this.child,
  }) {
    buttonType = ButtonType.text;
  }

  ArtistaButton.outline({
    super.key,
    this.onPressed,
    required this.buttonSize,
    required this.buttonColor,
    this.isFullWidth = false,
    required this.child,
  }) {
    buttonType = ButtonType.outline;
  }

  ArtistaButton.filled({
    super.key,
    this.onPressed,
    required this.buttonSize,
    required this.buttonColor,
    this.isFullWidth = false,
    required this.child,
  }) {
    buttonType = ButtonType.filled;
  }

  ArtistaButton.tonal({
    super.key,
    this.onPressed,
    required this.buttonSize,
    required this.buttonColor,
    this.isFullWidth = false,
    required this.child,
  }) {
    buttonType = ButtonType.tonal;
  }

  @override
  Widget build(BuildContext context) {
    if (buttonType == ButtonType.text) {
      return text(
        buttonSize: buttonSize,
        child: child,
        context: context,
        buttonColor: buttonColor,
        onPressed: onPressed,
        isFullWidth: isFullWidth,
      );
    } else if (buttonType == ButtonType.filled) {
      return filled(
        buttonSize: buttonSize,
        child: child,
        context: context,
        buttonColor: buttonColor,
        onPressed: onPressed,
        isFullWidth: isFullWidth,
      );
    } else if (buttonType == ButtonType.tonal) {
      return tonal(
        buttonSize: buttonSize,
        child: child,
        context: context,
        buttonColor: buttonColor,
        onPressed: onPressed,
        isFullWidth: isFullWidth,
      );
    } else if (buttonType == ButtonType.outline) {
      return outline(
        buttonSize: buttonSize,
        child: child,
        context: context,
        buttonColor: buttonColor,
        onPressed: onPressed,
        isFullWidth: isFullWidth,
      );
    } else if (buttonType == ButtonType.icon) {
      return outline(
        buttonSize: buttonSize,
        child: child,
        context: context,
        buttonColor: buttonColor,
        onPressed: onPressed,
        isFullWidth: isFullWidth,
      );
    } else {
      return elevated(
        buttonSize: buttonSize,
        child: child,
        context: context,
        buttonColor: buttonColor,
        onPressed: onPressed,
        isFullWidth: isFullWidth,
      );
    }
  }
}

enum ButtonType { text, elevated, filled, outline, tonal, icon }

enum ButtonSize { xl, lg, md, sm, xsm }

enum ButtonColor { info, primary, warning, danger, success, secondary }

Widget filled({
  required ButtonSize buttonSize,
  bool? isFullWidth = false,
  Function()? onPressed,
  required Widget child,
  required BuildContext context,
  required ButtonColor buttonColor,
}) {
  final inverseBW = InverseBW();
  final artista = getArtistaConfig<ArtistaConfig>();
  return SizedBox(
    width: isFullWidth! ? double.infinity : null,
    height: getHeight(buttonSize),
    child: FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: onPressed != null
            ? MaterialStatePropertyAll(
                HexColor.fromHex(
                  inverseBW.getInverseBW(
                    getColorOnly(buttonColor: buttonColor).toHex(),
                  ),
                ),
              )
            : null,
        backgroundColor:
            onPressed != null ? getColor(buttonColor: buttonColor) : null,
      ),
      child: child,
    ),
  );
}

Widget text({
  required ButtonSize buttonSize,
  bool? isFullWidth = false,
  Function()? onPressed,
  required Widget child,
  required BuildContext context,
  required ButtonColor buttonColor,
}) {
  return SizedBox(
    width: isFullWidth! ? double.infinity : null,
    height: getHeight(buttonSize),
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: getColor(buttonColor: buttonColor),
      ),
      child: child,
    ),
  );
}

Widget elevated({
  required ButtonSize buttonSize,
  bool? isFullWidth = true,
  Function()? onPressed,
  required Widget child,
  required BuildContext context,
  required ButtonColor buttonColor,
}) {
  final artista = getArtistaConfig<ArtistaConfig>();
  return SizedBox(
    width: isFullWidth! ? double.infinity : null,
    height: getHeight(buttonSize),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: onPressed != null
            ? getColor(buttonColor: buttonColor)
            : MaterialStatePropertyAll(artista.config.colors!.disable),
        backgroundColor:
            MaterialStatePropertyAll(getColorOnly(buttonColor: buttonColor)),
      ),
      child: child,
    ),
  );
}

Widget tonal({
  required ButtonSize buttonSize,
  bool? isFullWidth = false,
  Function()? onPressed,
  required Widget child,
  required BuildContext context,
  required ButtonColor buttonColor,
}) {
  return Container(
    width: isFullWidth! ? double.infinity : null,
    height: getHeight(buttonSize),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(1000),
      ),
      color: Colors.white,
    ),
    child: FilledButton.tonal(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor:
            onPressed != null ? getColor(buttonColor: buttonColor) : null,
        backgroundColor: onPressed != null
            ? getColor(
                buttonColor: buttonColor,
                buttonType: ButtonType.filled,
              )
            : null,
      ),
      child: child,
    ),
  );
}

Widget outline({
  required ButtonSize buttonSize,
  bool? isFullWidth = true,
  Function()? onPressed,
  required Widget child,
  required BuildContext context,
  required ButtonColor buttonColor,
}) {
  final artista = getArtistaConfig<ArtistaConfig>();
  return SizedBox(
    width: isFullWidth! ? double.infinity : null,
    height: getHeight(buttonSize),
    child: OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: onPressed != null
            ? getColor(buttonColor: buttonColor)
            : MaterialStatePropertyAll(artista.config.colors!.disable),
        side: MaterialStateProperty.resolveWith<BorderSide>((_) {
          return BorderSide(
            color: onPressed != null
                ? getColorOnly(buttonColor: buttonColor)
                : artista.config.colors!.disable!,
          );
        }),
      ),
      child: child,
    ),
  );
}

double getHeight(ButtonSize buttonSize) {
  if (buttonSize == ButtonSize.xl) {
    return 72;
  } else if (buttonSize == ButtonSize.lg) {
    return 65;
  } else if (buttonSize == ButtonSize.md) {
    return 50;
  } else if (buttonSize == ButtonSize.sm) {
    return 42;
  } else {
    return 36;
  }
}

/*double getWidth(ButtonSize buttonSize) {
  if (buttonSize == ButtonSize.xl) {
    return 108;
  } else if (buttonSize == ButtonSize.lg) {
    return 100;
  } else if (buttonSize == ButtonSize.xsm) {
    return 64;
  } else {
    return 82;
  }
}*/

MaterialStateProperty<Color?> getColor({
  required ButtonColor buttonColor,
  ButtonType? buttonType,
}) {
  final artista = getArtistaConfig<ArtistaConfig>();
  if (buttonType != null && buttonType == ButtonType.filled) {
    if (buttonColor == ButtonColor.success) {
      return MaterialStatePropertyAll(
        artista.config.colors!.success?.shade50.withOpacity(0.5),
      );
    } else if (buttonColor == ButtonColor.primary) {
      return MaterialStatePropertyAll(
        artista.config.colors!.primary?.shade50.withOpacity(0.5),
      );
    } else if (buttonColor == ButtonColor.info) {
      return MaterialStatePropertyAll(
        artista.config.colors!.info?.shade50.withOpacity(0.5),
      );
    } else if (buttonColor == ButtonColor.warning) {
      return MaterialStatePropertyAll(
        artista.config.colors!.warning?.shade50.withOpacity(0.5),
      );
    } else if (buttonColor == ButtonColor.secondary) {
      return MaterialStatePropertyAll(
        artista.config.colors!.secondary?.shade50.withOpacity(0.5),
      );
    } else {
      return MaterialStatePropertyAll(
        artista.config.colors!.danger?.shade50.withOpacity(0.5),
      );
    }
  } else {
    return MaterialStatePropertyAll(getColorOnly(buttonColor: buttonColor));
  }
}

MaterialColor getColorOnly({required ButtonColor buttonColor}) {
  final artista = getArtistaConfig<ArtistaConfig>();
  if (buttonColor == ButtonColor.success) {
    return artista.config.colors!.success!;
  } else if (buttonColor == ButtonColor.primary) {
    return artista.config.colors!.primary!;
  } else if (buttonColor == ButtonColor.info) {
    return artista.config.colors!.info!;
  } else if (buttonColor == ButtonColor.warning) {
    return artista.config.colors!.warning!;
  } else if (buttonColor == ButtonColor.secondary) {
    return artista.config.colors!.secondary!;
  } else {
    return artista.config.colors!.danger!;
  }
}
