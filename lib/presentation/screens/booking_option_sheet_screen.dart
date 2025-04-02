import 'package:flutter/material.dart';

void showBookingOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return BookingOptionsSheet();
    },
  );
}

class BookingOptionsSheet extends StatefulWidget {
  final DateTimeRange? initialDateRange;
  final int initialAdults;
  final int initialChildren;
  final int initialBabies;
  final int initialPets;

  BookingOptionsSheet({
    this.initialDateRange,
    this.initialAdults = 1,
    this.initialChildren = 0,
    this.initialBabies = 0,
    this.initialPets = 0,
  });

  @override
  _BookingOptionsSheetState createState() => _BookingOptionsSheetState();
}

class _BookingOptionsSheetState extends State<BookingOptionsSheet> {
   DateTimeRange? selectedDateRange;
  bool isDateSelected = true;
  int adults = 1;
  int children = 0;
  int babies = 0;
  int pets = 0;

  @override
  void initState() {
    super.initState();
    selectedDateRange = widget.initialDateRange;
    adults = widget.initialAdults;
    children = widget.initialChildren;
    babies = widget.initialBabies;
    pets = widget.initialPets;
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  "Thay đổi thông tin đặt phòng",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 48),
              ],
            ),
          ),

          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: Text("Ngày"),
                selected: isDateSelected,
                onSelected: (selected) {
                  setState(() {
                    isDateSelected = true;
                  });
                },
              ),
              SizedBox(width: 8),
              ChoiceChip(
                label: Text("Khách"),
                selected: !isDateSelected,
                onSelected: (selected) {
                  setState(() {
                    isDateSelected = false;
                  });
                },
              ),
            ],
          ),

          SizedBox(height: 16),

          // Nội dung theo tab
          Expanded(
            child: isDateSelected ? _buildDatePicker() : _buildGuestSelector(),
          ),

          SizedBox(height: 16),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        selectedDateRange = null;
                        adults = 1;
                        children = 0;
                        babies = 0;
                        pets = 0;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Hủy", style: TextStyle(fontSize: 16))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      "selectedDateRange": selectedDateRange,
                      "adults": adults,
                      "children": children,
                      "babies": babies,
                      "pets": pets,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "Lưu",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  // Widget chọn ngày
  Widget _buildDatePicker() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (selectedDateRange != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "${selectedDateRange!.start.day}/${selectedDateRange!.start.month} - ${selectedDateRange!.end.day}/${selectedDateRange!.end.month}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ElevatedButton(
          onPressed: _pickDateRange,
          child:
              Text(selectedDateRange == null ? "Chọn ngày" : "Thay đổi ngày"),
        ),
      ],
    );
  }

  // Hàm mở hộp chọn ngày
  Future<void> _pickDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDateRange: selectedDateRange,
    );
    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  // Widget chọn số khách
  Widget _buildGuestSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quý khách vui lòng chọn số người bên dưới.",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 16),
          _buildGuestRow("Người lớn", "Từ 13 tuổi trở lên", adults, (val) {
            setState(() => adults = val);
          }),
          _buildGuestRow("Trẻ em", "Độ tuổi 2 - 12", children, (val) {
            setState(() => children = val);
          }),
          _buildGuestRow("Em bé", "Dưới 2 tuổi", babies, (val) {
            setState(() => babies = val);
          }),
          _buildGuestRow("Thú cưng", "Bạn sẽ mang theo động vật?", pets, (val) {
            setState(() => pets = val);
          }),
        ],
      ),
    );
  }

  // khách
  Widget _buildGuestRow(
      String title, String subtitle, int count, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: count > 0 ? () => onChanged(count - 1) : null,
                icon: Icon(Icons.remove),
              ),
              Text("$count",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(
                onPressed: () => onChanged(count + 1),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
