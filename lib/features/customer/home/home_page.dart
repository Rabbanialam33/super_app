import 'package:flutter/material.dart';

import 'package:super_app/widgets/home/popular_services.dart';
import 'package:super_app/widgets/home/promotional_banner.dart';
import 'package:super_app/widgets/home/service_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Super App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Everything you need, in one place',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location
              InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                        ),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context)
                              .colorScheme
                              .primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deliver to',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Your current location',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Search
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search food, services, rides...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                  ),
                  suffixIcon: IconButton(
                    tooltip: 'Filters',
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune_rounded,
                    ),
                  ),
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

              const SizedBox(height: 20),

              // Promotional Banner
              const PromotionalBanner(),

              const SizedBox(height: 28),

              // Main categories
              const ServiceCategories(),

              const SizedBox(height: 32),

              // Popular services
              const PopularServices(),

              const SizedBox(height: 28),

              // Why Super App
              const Text(
                'Why Super App?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _FeatureCard(
                      icon: Icons.verified_user_outlined,
                      title: 'Trusted',
                      subtitle: 'Verified providers',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _FeatureCard(
                      icon: Icons.bolt_outlined,
                      title: 'Fast',
                      subtitle: 'Quick & easy service',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _FeatureCard(
                      icon: Icons.payments_outlined,
                      title: 'Secure',
                      subtitle: 'Safe payments',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _FeatureCard(
                      icon: Icons.support_agent_outlined,
                      title: 'Support',
                      subtitle: 'Help when you need it',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer,
            ),
            child: Icon(
              icon,
              size: 22,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}