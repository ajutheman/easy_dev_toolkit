import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A modern, expandable calendar widget designed for time logging or event tracking.
///
/// It features a weekly view that can be expanded into a full monthly view
/// with smooth animations and glassmorphism-inspired styling.
class TimeLogCalendar extends StatefulWidget {
  /// The initial date to be selected.
  final DateTime initialDate;

  /// Callback triggered when a date is selected.
  final ValueChanged<DateTime> onDateSelected;

  /// The background color of the calendar header.
  final Color backgroundColor;

  /// The color of the selected date indicator.
  final Color accentColor;

  const TimeLogCalendar({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    this.backgroundColor = const Color(0xFF253C8F),
    this.accentColor = Colors.white,
  });

  @override
  State<TimeLogCalendar> createState() => _TimeLogCalendarState();
}

class _TimeLogCalendarState extends State<TimeLogCalendar> {
  static const double _cellSize = 44;

  late DateTime selectedDate;
  bool expanded = false;

  PageController? _monthPageController;
  ScrollController? _weekScrollController;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    _monthPageController = PageController(initialPage: selectedDate.month - 1);
    _weekScrollController = ScrollController();
  }

  @override
  void dispose() {
    _monthPageController?.dispose();
    _weekScrollController?.dispose();
    super.dispose();
  }

  // ───────────────── DATE SELECT ─────────────────

  void _select(DateTime d) {
    setState(() => selectedDate = d);
    widget.onDateSelected(d);

    Future.delayed(const Duration(milliseconds: 120), () {
      if (!mounted) return;

      setState(() => expanded = false);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _centerSelectedDate();
      });
    });
  }

  // ───────────────── CENTER WEEK DATE ─────────────────

  void _centerSelectedDate() {
    if (_weekScrollController == null || !_weekScrollController!.hasClients) return;

    final index = selectedDate.weekday % 7;
    final screenWidth = MediaQuery.of(context).size.width;
    final targetOffset = (index * _cellSize) - (screenWidth / 2) + (_cellSize / 2);

    _weekScrollController?.animateTo(
      targetOffset.clamp(
        0.0,
        _weekScrollController!.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // ───────────────── MONTH CHANGE ─────────────────

  void _changeMonth(int offset) {
    final newDate = DateTime(
      selectedDate.year,
      selectedDate.month + offset,
      1,
    );

    final maxDays = DateUtils.getDaysInMonth(newDate.year, newDate.month);

    setState(() {
      selectedDate = DateTime(
        newDate.year,
        newDate.month,
        selectedDate.day.clamp(1, maxDays),
      );
    });

    _monthPageController?.animateToPage(
      newDate.month - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // ───────────────── BUILD ─────────────────

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (d) {
        if (d.delta.dy > 8) setState(() => expanded = true);
        if (d.delta.dy < -8) setState(() => expanded = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        height: expanded ? 480 : 170,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
        ),
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 12),
            _weekDaysHeader(),
            const SizedBox(height: 8),
            if (expanded) _monthSelectionStrip(),
            Expanded(
              child: expanded ? _monthPager() : _weekScroller(),
            ),
            const SizedBox(height: 8),
            _dragHandle(),
          ],
        ),
      ),
    );
  }

  // ───────────────── HEADER ─────────────────

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _monthName(selectedDate.month),
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          '${selectedDate.year}',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // ───────────────── WEEK DAYS ─────────────────

  Widget _weekDaysHeader() {
    const days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final isWeekend = i == 0 || i == 6;
        return SizedBox(
          width: _cellSize,
          child: Center(
            child: Text(
              days[i],
              style: GoogleFonts.poppins(
                color: isWeekend ? Colors.redAccent : Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
        );
      }),
    );
  }

  // ───────────────── WEEK VIEW ─────────────────

  Widget _weekScroller() {
    final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday % 7));

    return SingleChildScrollView(
      controller: _weekScrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (i) {
          final date = weekStart.add(Duration(days: i));
          return _dateCell(date);
        }),
      ),
    );
  }

  // ───────────────── MONTH STRIP ─────────────────

  Widget _monthSelectionStrip() {
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (i) {
          final offset = i - 2;
          final date = DateTime(
            selectedDate.year,
            selectedDate.month + offset,
            1,
          );

          final isSelected = date.month == selectedDate.month && date.year == selectedDate.year;

          return GestureDetector(
            onTap: () => _changeMonth(offset),
            child: SizedBox(
              width: 64,
              child: Center(
                child: Text(
                  _monthName(date.month),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Colors.white : Colors.white60,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ───────────────── MONTH PAGE VIEW ─────────────────

  Widget _monthPager() {
    return PageView.builder(
      controller: _monthPageController,
      onPageChanged: (index) {
        setState(() {
          selectedDate = DateTime(
            selectedDate.year,
            index + 1,
            selectedDate.day.clamp(
              1,
              DateUtils.getDaysInMonth(selectedDate.year, index + 1),
            ),
          );
        });
      },
      itemCount: 12,
      itemBuilder: (_, index) {
        return _monthGrid(index + 1);
      },
    );
  }

  Widget _monthGrid(int month) {
    final first = DateTime(selectedDate.year, month, 1);
    final days = DateUtils.getDaysInMonth(first.year, first.month);
    final offset = first.weekday % 7;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
        mainAxisSpacing: 6,
        crossAxisSpacing: 0,
      ),
      itemCount: days + offset,
      itemBuilder: (_, i) {
        if (i < offset) return const SizedBox();
        final day = i - offset + 1;
        return _dateCell(
          DateTime(selectedDate.year, month, day),
        );
      },
    );
  }

  // ───────────────── DATE CELL ─────────────────

  Widget _dateCell(DateTime d) {
    final selected = d.year == selectedDate.year && d.month == selectedDate.month && d.day == selectedDate.day;
    final isWeekend = d.weekday == DateTime.saturday || d.weekday == DateTime.sunday;
    Color textColor;

    if (selected) {
      textColor = widget.backgroundColor;
    } else if (isWeekend) {
      textColor = Colors.redAccent;
    } else {
      textColor = Colors.white;
    }

    return SizedBox(
      width: _cellSize,
      height: _cellSize,
      child: Center(
        child: GestureDetector(
          onTap: () => _select(d),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? widget.accentColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${d.day}',
              style: GoogleFonts.poppins(
                color: textColor,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────── HELPERS ─────────────────

  Widget _dragHandle() => Container(
        width: 46,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(10),
        ),
      );

  String _monthName(int m) => const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m - 1];
}
