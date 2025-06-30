import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../booking/booking_screen.dart';
import '../booking/parcel_screen.dart';

const List<String> locationSuggestions = [
  'Chu Lai',
  'Đà Nẵng',
  'Tam Kỳ',
];


final List<Map<String, dynamic>> demoTrips = [
  {
    'route': 'Chu Lai → Đà Nẵng',
    'from': 'Chu Lai',
    'to': 'Đà Nẵng',
    'date': DateTime(2025, 7, 25),
    'time': '08:00 • 13:30',
    'price': '180.000đ',
  },
  {
    'route': 'Chu Lai → Tam Kỳ',
    'from': 'Chu Lai',
    'to': 'Tam Kỳ',
    'date': DateTime(2025, 7, 25),
    'time': '09:30 • 11:00',
    'price': '90.000đ',
  },
  {
    'route': 'Đà Nẵng → Tam Kỳ',
    'from': 'Đà Nẵng',
    'to': 'Tam Kỳ',
    'date': DateTime(2025, 7, 26),
    'time': '10:00 • 12:00',
    'price': '120.000đ',
  },
  {
    'route': 'Tam Kỳ → Chu Lai',
    'from': 'Tam Kỳ',
    'to': 'Chu Lai',
    'date': DateTime(2025, 7, 25),
    'time': '13:00 • 14:00',
    'price': '90.000đ',
  },
  {
    'route': 'Đà Nẵng → Chu Lai',
    'from': 'Đà Nẵng',
    'to': 'Chu Lai',
    'date': DateTime(2025, 7, 26),
    'time': '07:00 • 11:30',
    'price': '180.000đ',
  },
  {
    'route': 'Tam Kỳ → Đà Nẵng',
    'from': 'Tam Kỳ',
    'to': 'Đà Nẵng',
    'date': DateTime(2025, 7, 27),
    'time': '16:00 • 18:00',
    'price': '120.000đ',
  },
  {
    'route': 'Chu Lai → Đà Nẵng',
    'from': 'Chu Lai',
    'to': 'Đà Nẵng',
    'date': DateTime(2025, 7, 28),
    'time': '08:00 • 13:30',
    'price': '180.000đ',
  },
  {
    'route': 'Đà Nẵng → Tam Kỳ',
    'from': 'Đà Nẵng',
    'to': 'Tam Kỳ',
    'date': DateTime(2025, 7, 28),
    'time': '13:30 • 15:30',
    'price': '120.000đ',
  },
  {
    'route': 'Đà Nẵng → Tam Kỳ',
    'from': 'Đà Nẵng',
    'to': 'Tam Kỳ',
    'date': DateTime(2025, 7, 28),
    'time': '16:30 • 18:30',
    'price': '120.000đ',
  },
  {
    'route': 'Chu Lai → Tam Kỳ',
    'from': 'Chu Lai',
    'to': 'Tam Kỳ',
    'date': DateTime(2025, 7, 28),
    'time': '17:00 • 18:30',
    'price': '90.000đ',
  },
  {
    'route': 'Tam Kỳ → Chu Lai',
    'from': 'Tam Kỳ',
    'to': 'Chu Lai',
    'date': DateTime(2025, 7, 29),
    'time': '06:30 • 07:30',
    'price': '90.000đ',
  },
  {
    'route': 'Chu Lai → Đà Nẵng',
    'from': 'Chu Lai',
    'to': 'Đà Nẵng',
    'date': DateTime(2025, 7, 29),
    'time': '10:00 • 15:00',
    'price': '180.000đ',
  },
  {
    'route': 'Đà Nẵng → Chu Lai',
    'from': 'Đà Nẵng',
    'to': 'Chu Lai',
    'date': DateTime(2025, 7, 29),
    'time': '18:00 • 22:30',
    'price': '180.000đ',
  },
  {
    'route': 'Chu Lai → Đà Nẵng',
    'from': 'Chu Lai',
    'to': 'Đà Nẵng',
    'date': DateTime(2025, 8, 1),
    'time': '07:30 • 13:00',
    'price': '180.000đ',
  },
  {
    'route': 'Tam Kỳ → Đà Nẵng',
    'from': 'Tam Kỳ',
    'to': 'Đà Nẵng',
    'date': DateTime(2025, 8, 1),
    'time': '11:00 • 13:00',
    'price': '120.000đ',
  },
  {
    'route': 'Đà Nẵng → Chu Lai',
    'from': 'Đà Nẵng',
    'to': 'Chu Lai',
    'date': DateTime(2025, 8, 2),
    'time': '08:00 • 12:00',
    'price': '180.000đ',
  },
  {
    'route': 'Tam Kỳ → Chu Lai',
    'from': 'Tam Kỳ',
    'to': 'Chu Lai',
    'date': DateTime(2025, 8, 2),
    'time': '15:00 • 16:00',
    'price': '90.000đ',
  },
];



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  DateTime? _selectedDate;
  List<Map<String, dynamic>> _searchResults = [];
  bool _hasSearched = false;
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  void _selectDate(BuildContext context) async {
    HapticFeedback.lightImpact();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 180)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xFF2E7D32),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _swapLocations() {
    HapticFeedback.mediumImpact();
    setState(() {
      String temp = _fromController.text;
      _fromController.text = _toController.text;
      _toController.text = temp;
    });
  }

  Future<void> _searchBus() async {
    String from = _fromController.text.trim();
    String to = _toController.text.trim();
    DateTime? date = _selectedDate;

    if (from.isEmpty || to.isEmpty || date == null) {
      _showSnackBar('Vui lòng nhập đầy đủ thông tin tìm kiếm!', isError: true);
      return;
    }

    if (from.toLowerCase() == to.toLowerCase()) {
      _showSnackBar('Điểm đi và điểm đến không thể giống nhau!', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isLoading = false;
      _hasSearched = true;
      _searchResults = demoTrips.where((trip) {
        return trip['from'].toLowerCase() == from.toLowerCase() &&
            trip['to'].toLowerCase() == to.toLowerCase() &&
            trip['date'].year == date.year &&
            trip['date'].month == date.month &&
            trip['date'].day == date.day;
      }).toList();
    });

    if (_searchResults.isNotEmpty) {
      _showSnackBar('Tìm thấy ${_searchResults.length} chuyến xe phù hợp!');
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? Colors.red[600] : Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern SliverAppBar with gradient
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Thanh Thiện Bus',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2E7D32),
                      Color(0xFF4CAF50),
                      Color(0xFF66BB6A),
                    ],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tìm kiếm
                      _buildSearchCard(),

                      const SizedBox(height: 24),


                      const SizedBox(height: 32),

                      if (_searchResults.isNotEmpty) ...[
                        _buildSectionTitle('Kết quả tìm kiếm', _searchResults.length),
                        const SizedBox(height: 16),
                        ..._searchResults.map((trip) => _BusCard(
                          route: trip['route'],
                          time: trip['time'],
                          price: trip['price'],
                          duration: trip['duration'] ?? '5h 30m',
                          availableSeats: trip['seats'] ?? 12,
                        )),
                      ] else if (_hasSearched && _searchResults.isEmpty) ...[
                        _buildNoResultsWidget(),
                      ] else ...[
                        _buildSectionTitle('Chuyến xe phổ biến', 2),
                        const SizedBox(height: 16),
                        _BusCard(
                          route: 'Chu Lai → Đà Nẵng',
                          time: '08:00 • 13:30',
                          price: '180.000đ',
                          duration: '5h 30m',
                          availableSeats: 12,
                        ),
                        const SizedBox(height: 12),
                        _BusCard(
                          route: 'Chu Lai → Tam Kỳ',
                          time: '09:30 • 11:00',
                          price: '90.000đ',
                          duration: '1h 30m',
                          availableSeats: 8,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSearchCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tìm chuyến xe',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 20),

            // Điểm đi, điểm đến và nuút hoán đổi
            Row(
              children: [
                Expanded(child: _buildLocationField(_fromController, 'Điểm đi', Icons.my_location)),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: _swapLocations,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.swap_horiz,
                        color: Color(0xFF2E7D32),
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(child: _buildLocationField(_toController, 'Điểm đến', Icons.location_on)),
              ],
            ),

            const SizedBox(height: 16),

            // Date picker
            _buildDatePicker(),

            const SizedBox(height: 24),

            // Search button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _searchBus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, size: 20, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Tìm chuyến xe',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationField(TextEditingController controller, String label, IconData icon) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return locationSuggestions.where((String option) {
          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (context, fieldController, focusNode, onFieldSubmitted) {
        fieldController.text = controller.text;
        fieldController.addListener(() {
          controller.text = fieldController.text;
        });
        return TextField(
          controller: fieldController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: const Color(0xFF2E7D32)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        );
      },
      onSelected: (String selection) {
        controller.text = selection;
      },
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade50,
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Color(0xFF2E7D32)),
            const SizedBox(width: 12),
            Text(
              _selectedDate == null
                  ? 'Chọn ngày đi'
                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              style: TextStyle(
                color: _selectedDate == null ? Colors.grey.shade600 : Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: const TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoResultsWidget() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Không tìm thấy chuyến xe',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thử thay đổi điểm đi, điểm đến hoặc ngày khác',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BusCard extends StatefulWidget {
  final String route;
  final String time;
  final String price;
  final String duration;
  final int availableSeats;

  const _BusCard({
    required this.route,
    required this.time,
    required this.price,
    required this.duration,
    required this.availableSeats,
  });

  @override
  State<_BusCard> createState() => _BusCardState();
}

class _BusCardState extends State<_BusCard> with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.directions_bus,
                color: Color(0xFF2E7D32),
                size: 24,
              ),
            ),
            title: Text(
              widget.route,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(widget.time),
                    const SizedBox(width: 16),
                    const Icon(Icons.schedule, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(widget.duration),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.event_seat, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('${widget.availableSeats} chỗ trống'),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.price,
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ],
            ),
            onTap: _toggleExpanded,
          ),
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingScreen(
                              route: widget.route,
                              time: widget.time,
                              price: widget.price,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.confirmation_number, size: 18, color: Colors.white),
                      label: const Text(
                        'Đặt vé',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ParcelScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.local_shipping, size: 18,color: Colors.white),
                      label: const Text(
                        'Gửi hàng',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}