import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A model representing a day in the [HorizontalDateSelector].
class DateSelectorDay {
  /// The underlying date object.
  final DateTime date;

  /// The top label (e.g., month "Oct").
  final String labelTop;

  /// The day number (e.g., "23").
  final String dayNumber;

  /// The bottom label (e.g., weekday "Mon").
  final String labelBottom;

  /// Creates a date selector day model.
  const DateSelectorDay({
    required this.date,
    required this.labelTop,
    required this.dayNumber,
    required this.labelBottom,
  });

  /// Factory constructor to create a day from [DateTime].
  factory DateSelectorDay.fromDateTime(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return DateSelectorDay(
      date: date,
      labelTop: months[date.month - 1],
      dayNumber: date.day.toString(),
      labelBottom: weekdays[date.weekday % 7],
    );
  }
}

/// A horizontal date selection widget with auto-scrolling capabilities.
///
/// This widget provides a sleek, modern way to choose dates from a horizontal list.
/// It automatically centers the selected date and supports custom styling.
class HorizontalDateSelector extends StatefulWidget {
  /// The list of days to display.
  final List<DateSelectorDay> days;

  /// The index of the initially selected date.
  final int initialSelectedIndex;

  /// Callback triggered when a date is selected.
  final ValueChanged<int> onDateSelected;

  /// The color of the active (selected) date card.
  final Color activeColor;

  /// The background color of inactive date cards.
  final Color inactiveColor;

  /// The border color of the date cards.
  final Color borderColor;

  /// The text color for active cards.
  final Color activeTextColor;

  /// The text color for inactive cards.
  final Color inactiveTextColor;

  /// Creates a horizontal date selector.
  const HorizontalDateSelector({
    super.key,
    required this.days,
    this.initialSelectedIndex = 0,
    required this.onDateSelected,
    this.activeColor = const Color.fromRGBO(218, 70, 63, 1),
    this.inactiveColor = Colors.white,
    this.borderColor = const Color(0xFFEDEDED),
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.black,
  });

  @override
  State<HorizontalDateSelector> createState() => _HorizontalDateSelectorState();
}

class _HorizontalDateSelectorState extends State<HorizontalDateSelector> {
  late int selectedIndex;
  late ScrollController _scrollController;
  static const double _itemWidth = 64.0;
  static const double _separatorWidth = 12.0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialSelectedIndex;
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(selectedIndex);
    });
  }

  @override
  void didUpdateWidget(HorizontalDateSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedIndex != oldWidget.initialSelectedIndex) {
      selectedIndex = widget.initialSelectedIndex;
      _scrollToIndex(selectedIndex);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    if (!_scrollController.hasClients) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final targetOffset = (index * (_itemWidth + _separatorWidth)) - (screenWidth / 2) + (_itemWidth / 2) + 16; // +16 for start padding

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.days.length,
        separatorBuilder: (_, __) => const SizedBox(width: _separatorWidth),
        itemBuilder: (context, i) {
          final day = widget.days[i];
          final bool active = selectedIndex == i;

          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = i);
              widget.onDateSelected(i);
              _scrollToIndex(i);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: _itemWidth,
              decoration: BoxDecoration(
                color: active ? widget.activeColor : widget.inactiveColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: widget.borderColor),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.labelTop,
                    style: GoogleFonts.poppins(
                      color: active ? widget.activeTextColor : widget.inactiveTextColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    day.dayNumber,
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: active ? widget.activeTextColor : widget.inactiveTextColor,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    day.labelBottom,
                    style: GoogleFonts.poppins(
                      color: active ? widget.activeTextColor : widget.inactiveTextColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
