import 'package:film_freund/services/local_settings/region.dart';
import 'package:film_freund/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegionButtonPanel extends StatefulWidget {
  const RegionButtonPanel({Key? key}) : super(key: key);

  @override
  _RegionButtonPanelState createState() => _RegionButtonPanelState();
}

class _RegionButtonPanelState extends State<RegionButtonPanel> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final region in Region.values) ...[
          const Gap(8),
          RegionButton(
            key: Key(region.countryCode),
            imageUrl: region.imageUrl,
            onPressed: () {
              ServiceLocator.localSettings.region = region;
              setState(() {});
            },
            isSelected: ServiceLocator.localSettings.region == region,
          ),
        ],
      ],
    );
  }
}

extension RegionImageExtensions on Region {
  @visibleForTesting
  String get imageUrl => 'https://raw.githubusercontent.com/swantzter/square-flags/master/png/1x1/256/$countryCode.png';
}

class RegionButton extends StatelessWidget {
  const RegionButton({
    required this.imageUrl,
    required this.onPressed,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.5,
            duration: const Duration(milliseconds: 250),
            child: Image.network(
              imageUrl,
              width: 40,
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
