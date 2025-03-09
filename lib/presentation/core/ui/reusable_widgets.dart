import 'package:bruce_omukoko_portfolio/presentation/core/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

///Drop Down Menu with button
///Not searchable
class DropDownMenuButton<T> extends StatelessWidget {
  DropDownMenuButton({
    this.hint,
    this.initialSelection,
    required this.isEquals,
    this.width = double.infinity,
    required this.onSelect,
    this.options = const [],
    required this.label,
    super.key,
  });

  final String? hint;
  final T? initialSelection;
  final void Function(T) onSelect;
  final String Function(T) label;
  final List<T> options;
  final double width;
  final bool Function(T listItem, T? item) isEquals;
  late final ValueNotifier<T?> _valueNotifier = ValueNotifier(
      options.where((e) => isEquals(e, initialSelection)).firstOrNull);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _valueNotifier,
      builder: (context, value, _) {
        return DropdownButton<T>(
          isExpanded: false,
          hint: Text(
            hint ?? "e.g ${options.isEmpty ? '' : label(options.first)}",
          ),
          value: value,
          alignment: Alignment.center,
          //style: itemStyle,
          //underline: itemUnderline,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          //focusColor: HexColor("#A9D2F0"),
          // dropdownColor: Colors.white,
          elevation: 12,
          onChanged: (newValue) {
            if (newValue != null) {
              onSelect(newValue);
              _valueNotifier.value = newValue;
            }
          },
          items: options
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Center(
                    child: Text(
                      label(e),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                      //style: itemStyle,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class OnHover extends StatelessWidget {
  OnHover({
    required this.builder,
    this.animationDuration = const Duration(milliseconds: 100),
    super.key,
  });

  final Widget Function(bool isHovered) builder;
  final Duration animationDuration;
  final ValueNotifier<bool> isHovered = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        child: ValueListenableBuilder(
          valueListenable: isHovered,
          builder: (__, bool hovered, ___) => builder.call(hovered),
        ),
      ),
    );
  }
}

Image get background => Image.asset(
  "bruc3balo/assets/background.png",
  fit: BoxFit.fill,
  width: double.infinity,
  height: double.infinity,
);

class InfiniteLoader extends StatelessWidget {
  const InfiniteLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: LoadingAnimationWidget.beat(
        color: orange,
        size: 200,
      ),
    );
  }
}
