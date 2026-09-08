import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController =
      TextEditingController();

  final List<_SearchItem> _items = const [
    _SearchItem(
      icon: Icons.restaurant,
      title: 'Food Delivery',
      category: 'Food',
      subtitle: 'Restaurants, meals & dishes',
    ),
    _SearchItem(
      icon: Icons.shopping_bag,
      title: 'Shopping',
      category: 'Shopping',
      subtitle: 'Products & local stores',
    ),
    _SearchItem(
      icon: Icons.delivery_dining,
      title: 'Parcel Delivery',
      category: 'Delivery',
      subtitle: 'Pickup & drop service',
    ),
    _SearchItem(
      icon: Icons.local_taxi,
      title: 'Ride Booking',
      category: 'Ride',
      subtitle: 'Bike, Auto, Car & XL',
    ),
    _SearchItem(
      icon: Icons.people,
      title: 'Manpower',
      category: 'Manpower',
      subtitle: 'Workers & professionals',
    ),
    _SearchItem(
      icon: Icons.home_repair_service,
      title: 'Home Services',
      category: 'Services',
      subtitle: 'Repair, cleaning & maintenance',
    ),
  ];

  List<_SearchItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
    _searchController.addListener(_performSearch);
  }

  void _performSearch() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredItems = _items;
      } else {
        _filteredItems = _items.where((item) {
          return item.title.toLowerCase().contains(query) ||
              item.category.toLowerCase().contains(query) ||
              item.subtitle.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search food, services, rides...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: const Icon(
                          Icons.clear_rounded,
                        ),
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _filteredItems.isEmpty
                  ? const _EmptySearchState()
                  : ListView.separated(
                      itemCount: _filteredItems.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];

                        return _SearchResultCard(
                          item: item,
                          onTap: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchItem {
  final IconData icon;
  final String title;
  final String category;
  final String subtitle;

  const _SearchItem({
    required this.icon,
    required this.title,
    required this.category,
    required this.subtitle,
  });
}

class _SearchResultCard extends StatelessWidget {
  final _SearchItem item;
  final VoidCallback onTap;

  const _SearchResultCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context)
                .colorScheme
                .primaryContainer,
          ),
          child: Icon(
            item.icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${item.category} • ${item.subtitle}',
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
        ),
      ),
    );
  }
}

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No results found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try searching for another service',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}