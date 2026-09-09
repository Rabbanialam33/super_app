import 'package:flutter/material.dart';
import 'package:super_app/core/location/models/customer_location_selection_model.dart';
import 'package:super_app/core/location/models/location_model.dart';
import 'package:super_app/core/location/services/customer_location_selection_service.dart';

class CustomerLocationSelectionPage extends StatefulWidget {
  const CustomerLocationSelectionPage({
    super.key,
    this.initialLocation,
  });

  final LocationModel? initialLocation;

  @override
  State<CustomerLocationSelectionPage> createState() =>
      _CustomerLocationSelectionPageState();
}

class _CustomerLocationSelectionPageState
    extends State<CustomerLocationSelectionPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  final CustomerLocationSelectionService _locationService =
      const CustomerLocationSelectionService();

  LocationModel? _selectedLocation;
  bool _isLoading = false;
  String? _statusMessage;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _loadInitialLocation();
  }

  void _loadInitialLocation() {
    final LocationModel? location = widget.initialLocation;

    if (location == null) {
      return;
    }

    _nameController.text = location.name ?? '';
    _addressController.text = location.address ?? '';
    _stateController.text = location.state ?? '';
    _districtController.text = location.district ?? '';
    _cityController.text = location.city ?? '';
    _areaController.text = location.area ?? '';
    _pinCodeController.text = location.pinCode ?? '';

    _selectedLocation = location;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _stateController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  LocationModel _buildLocation() {
    return LocationModel(
      id: _selectedLocation?.id ?? 'CUSTOMER-LOCATION',
      name: _nameController.text.trim(),
      address: _addressController.text.trim(),
      state: _stateController.text.trim(),
      district: _districtController.text.trim(),
      city: _cityController.text.trim(),
      area: _areaController.text.trim(),
      pinCode: _pinCodeController.text.trim(),
      latitude: _selectedLocation?.latitude,
      longitude: _selectedLocation?.longitude,
      countryCode: _selectedLocation?.countryCode ?? 'IN',
      isActive: true,
    );
  }

  Future<void> _checkLocation() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
      _statusMessage = null;
      _isSuccess = false;
    });

    final LocationModel location = _buildLocation();

    try {
      final CustomerLocationSelectionModel selection =
          await _locationService.createSelectionForLocation(location);

      if (!mounted) {
        return;
      }

      setState(() {
        _selectedLocation = location;
        _statusMessage = selection.errorMessage ??
            'Location is available in your area';
        _isSuccess = selection.hasZone;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _statusMessage =
            'Unable to check this location. Please try again.';
        _isSuccess = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _confirmLocation() async {
    if (_selectedLocation == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final CustomerLocationSelectionModel selection =
          await _locationService.confirmLocation(_selectedLocation!);

      if (!mounted) {
        return;
      }

      if (selection.isConfirmed) {
        Navigator.of(context).pop(selection);
        return;
      }

      setState(() {
        _statusMessage = selection.errorMessage ??
            'Service is not available in your area yet';
        _isSuccess = false;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _statusMessage =
            'Unable to confirm this location. Please try again.';
        _isSuccess = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            children: [
              _buildHeader(theme),
              const SizedBox(height: 24),
              _buildLocationForm(),
              const SizedBox(height: 20),
              _buildCheckButton(),
              if (_statusMessage != null) ...[
                const SizedBox(height: 20),
                _buildStatusCard(theme),
              ],
              if (_isSuccess) ...[
                const SizedBox(height: 20),
                _buildConfirmButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: theme.colorScheme.primary,
            child: Icon(
              Icons.location_on_rounded,
              color: theme.colorScheme.onPrimary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your location',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Enter your area to see services available near you.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationForm() {
    return Column(
      children: [
        _buildTextField(
          controller: _nameController,
          label: 'Location Name',
          hint: 'Example: Home',
          icon: Icons.bookmark_outline_rounded,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _addressController,
          label: 'Address',
          hint: 'House / Street / Landmark',
          icon: Icons.home_outlined,
          maxLines: 2,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _stateController,
          label: 'State',
          hint: 'Example: West Bengal',
          icon: Icons.map_outlined,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _districtController,
          label: 'District',
          hint: 'Example: Jalpaiguri',
          icon: Icons.location_city_outlined,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _cityController,
          label: 'City / Town',
          hint: 'Example: Dhupguri',
          icon: Icons.apartment_outlined,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _areaController,
          label: 'Area',
          hint: 'Example: Dhupguri Town',
          icon: Icons.place_outlined,
        ),
        const SizedBox(height: 14),
        _buildTextField(
          controller: _pinCodeController,
          label: 'PIN Code',
          hint: 'Enter 6 digit PIN code',
          icon: Icons.pin_drop_outlined,
          keyboardType: TextInputType.number,
          maxLength: 6,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    int? maxLength,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction:
          maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return '$label is required';
        }

        if (label == 'PIN Code' &&
            !RegExp(r'^\d{6}$').hasMatch(value.trim())) {
          return 'Enter a valid 6 digit PIN code';
        }

        return null;
      },
    );
  }

  Widget _buildCheckButton() {
    return SizedBox(
      height: 54,
      child: FilledButton.icon(
        onPressed: _isLoading ? null : _checkLocation,
        icon: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.search_rounded),
        label: Text(
          _isLoading ? 'Checking...' : 'Check Service Availability',
        ),
      ),
    );
  }

  Widget _buildStatusCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _isSuccess
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _isSuccess
                ? Icons.check_circle_rounded
                : Icons.info_outline_rounded,
            color: _isSuccess
                ? theme.colorScheme.primary
                : theme.colorScheme.error,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _statusMessage!,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      height: 54,
      child: FilledButton.icon(
        onPressed: _isLoading ? null : _confirmLocation,
        icon: const Icon(Icons.check_rounded),
        label: const Text('Confirm Location'),
      ),
    );
  }
}