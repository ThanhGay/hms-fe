import 'package:flutter/material.dart';

class SearchOverlay extends StatefulWidget {
  final void Function({
    required bool lowToHigh,
    required bool highToLow,
    required bool doubleRoom,
    required bool singleRoom,
    required String keyword,
  }) onSearch;

  const SearchOverlay({super.key, required this.onSearch});

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchKeywordController = TextEditingController();

  bool _lowToHigh = false;
  bool _highToLow = false;
  bool _doubleRoom = false;
  bool _singleRoom = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  void _closeOverlay() {
    _controller.reverse().then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onSearch() {
    widget.onSearch(
      lowToHigh: _lowToHigh,
      highToLow: _highToLow,
      doubleRoom: _doubleRoom,
      singleRoom: _singleRoom,
      keyword: _searchKeywordController.text.trim(),
    );

    _closeOverlay();
  }

  @override
  void dispose() {
    _searchKeywordController.dispose(); // Đừng quên dispose controller
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 2;

    return Material(
      color: Colors.black45,
      child: Stack(
        children: [
          GestureDetector(
            onTap: _closeOverlay,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: height,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    TextField(
                      controller: _searchKeywordController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Nhập từ khóa tìm kiếm...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bộ lọc',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CheckboxListTile(
                          title: const Text('Giá từ thấp lên cao'),
                          value: _lowToHigh,
                          onChanged: (val) {
                            setState(() {
                              _lowToHigh = val!;
                              if (_lowToHigh) _highToLow = false; // bỏ chọn cái còn lại
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: const Text('Giá từ cao xuống thấp'),
                          value: _highToLow,
                          onChanged: (val) {
                            setState(() {
                              _highToLow = val!;
                              if (_highToLow) _lowToHigh = false; // bỏ chọn cái còn lại
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: const Text('Phòng đôi'),
                          value: _doubleRoom,
                          onChanged: (val) => setState(() => _doubleRoom = val!),
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        CheckboxListTile(
                          title: const Text('Phòng đơn'),
                          value: _singleRoom,
                          onChanged: (val) => setState(() => _singleRoom = val!),
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ],
                    ),

                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _onSearch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Tìm kiếm',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
