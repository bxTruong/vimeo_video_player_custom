import 'package:flutter/material.dart';

import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

class SheetQualityComp extends StatefulWidget {
  final List<ProgressiveModel?> vimeoProgressiveList;
  final ProgressiveModel? vimeoProgressiveSelected;

  const SheetQualityComp({Key? key, required this.vimeoProgressiveList, this.vimeoProgressiveSelected}) : super(key: key);

  @override
  State<SheetQualityComp> createState() => _SheetQualityCompState();
}

class _SheetQualityCompState extends State<SheetQualityComp> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        shrinkWrap: true,
        itemBuilder: _itemBuilder,
        separatorBuilder: (_, __) => const SizedBox(height: 0),
        itemCount: widget.vimeoProgressiveList.length);
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Visibility(
                visible: widget.vimeoProgressiveSelected?.rendition == widget.vimeoProgressiveList[index]?.rendition,
                child: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.done, color: Colors.black),
                ),
              ),
              Expanded(
                  child: Text(widget.vimeoProgressiveList[index]?.rendition?.toString() ?? 'null',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.black,
                          fontWeight: widget.vimeoProgressiveSelected?.rendition == widget.vimeoProgressiveList[index]?.rendition
                              ? FontWeight.bold
                              : FontWeight.normal)))
            ],
          ),
        ),
        onTap: () => _onPressItemQuality(widget.vimeoProgressiveList[index]));
  }

  void _onPressItemQuality(ProgressiveModel? progressiveModel) => Navigator.pop(context, progressiveModel);
}
