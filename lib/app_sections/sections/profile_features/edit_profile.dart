import 'package:flutter/material.dart';
import 'package:getfit/components/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _nameController = TextEditingController(text: 'Pranav');
  final _emailController = TextEditingController(text: 'pranav@email.com');
  final _phoneController = TextEditingController(text: '+91 9876543210');
  final _ageController = TextEditingController(text: '25');
  final _heightController = TextEditingController(text: '175');
  final _weightController = TextEditingController(text: '70');

  String _selectedGender = 'Male';
  String _selectedGoal = 'Build Muscle';
  String _selectedActivityLevel = 'Moderately Active';

  // Responsive breakpoints (same as profile screen)
  bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768;
  bool _isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
  bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  EdgeInsets _getResponsivePadding(BuildContext context) {
    if (_isDesktop(context)) return const EdgeInsets.all(32.0);
    if (_isTablet(context)) return const EdgeInsets.all(24.0);
    return const EdgeInsets.all(16.0);
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    if (_isDesktop(context)) return baseSize + 4;
    if (_isTablet(context)) return baseSize + 2;
    return baseSize;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  // Section header widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: _isMobile(context) ? 4 : 8,
        bottom: _isMobile(context) ? 12 : 16,
        top: _isMobile(context) ? 16 : 20,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: _getResponsiveFontSize(context, 18),
          color: AppColors.font1,
        ),
      ),
    );
  }

  // Text field widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    String? suffix,
    int maxLines = 1,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 16 : 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        style: TextStyle(
          color: AppColors.font1,
          fontSize: _getResponsiveFontSize(context, 16),
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: _getResponsiveFontSize(context, 14),
          ),
          prefixIcon: Icon(icon, color: AppColors.buttons, size: 20),
          suffixText: suffix,
          suffixStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: _getResponsiveFontSize(context, 14),
          ),
          filled: true,
          fillColor: Theme.of(context).cardTheme.color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.dividerColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.buttons, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade400),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade400, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: _isMobile(context) ? 16 : 20,
          ),
        ),
      ),
    );
  }

  // Dropdown field widget
  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: _isMobile(context) ? 16 : 20),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: _getResponsiveFontSize(context, 14),
          ),
          prefixIcon: Icon(icon, color: AppColors.buttons, size: 20),
          filled: true,
          fillColor: Theme.of(context).cardTheme.color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.dividerColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.buttons, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: _isMobile(context) ? 16 : 20,
          ),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: AppColors.font1,
                fontSize: _getResponsiveFontSize(context, 16),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        dropdownColor: Theme.of(context).cardTheme.color,
      ),
    );
  }

  // Form section widget
  Widget _buildFormSection({required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.all(_isMobile(context) ? 20 : 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // Save profile function
  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically save the data to your backend/database
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully!'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      // Navigate back to profile screen
      Navigator.pop(context);
    }
  }

  // Discard changes dialog
  Future<void> _showDiscardDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Discard Changes?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _getResponsiveFontSize(context, 18),
              color: AppColors.font1,
            ),
          ),
          content: Text(
            'Are you sure you want to discard your changes?',
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              color: AppColors.textSecondary,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: _getResponsiveFontSize(context, 14),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Discard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _getResponsiveFontSize(context, 14),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to profile screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = _getResponsivePadding(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _getResponsiveFontSize(context, 24),
            color: AppColors.font1,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.font1),
        actions: [
          TextButton(
            onPressed: _showDiscardDialog,
            child: Text(
              'Discard',
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: _getResponsiveFontSize(context, 14),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(_isMobile(context) ? 20 : 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade600, Colors.teal.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: _isMobile(context) ? 40 : 50,
                      ),
                      SizedBox(height: _isMobile(context) ? 12 : 16),
                      Text(
                        'Update Your Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: _getResponsiveFontSize(context, 20),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Keep your information up to date',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: _getResponsiveFontSize(context, 14),
                        ),
                      ),
                    ],
                  ),
                ),

                // Personal Information Section
                _buildSectionHeader('Personal Information'),
                _buildFormSection(
                  children: [
                    _buildTextField(
                      controller: _nameController,
                      label: 'Full Name',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _ageController,
                            label: 'Age',
                            icon: Icons.cake_outlined,
                            keyboardType: TextInputType.number,
                            suffix: 'years',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter age';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDropdownField(
                            label: 'Gender',
                            value: _selectedGender,
                            items: ['Male', 'Female', 'Other'],
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedGender = newValue!;
                              });
                            },
                            icon: Icons.wc_outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Physical Information Section
                _buildSectionHeader('Physical Information'),
                _buildFormSection(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _heightController,
                            label: 'Height',
                            icon: Icons.height,
                            keyboardType: TextInputType.number,
                            suffix: 'cm',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter height';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _weightController,
                            label: 'Weight',
                            icon: Icons.monitor_weight_outlined,
                            keyboardType: TextInputType.number,
                            suffix: 'kg',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter weight';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    _buildDropdownField(
                      label: 'Fitness Goal',
                      value: _selectedGoal,
                      items: [
                        'Lose Weight',
                        'Build Muscle',
                        'Maintain Weight',
                        'Improve Endurance',
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGoal = newValue!;
                        });
                      },
                      icon: Icons.flag_outlined,
                    ),
                    _buildDropdownField(
                      label: 'Activity Level',
                      value: _selectedActivityLevel,
                      items: [
                        'Sedentary',
                        'Lightly Active',
                        'Moderately Active',
                        'Very Active',
                        'Extremely Active',
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedActivityLevel = newValue!;
                        });
                      },
                      icon: Icons.directions_run_outlined,
                    ),
                  ],
                ),

                SizedBox(height: _isMobile(context) ? 24 : 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _showDiscardDialog,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.dividerColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: _isMobile(context) ? 16 : 20,
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: _getResponsiveFontSize(context, 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttons,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: _isMobile(context) ? 16 : 20,
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: _getResponsiveFontSize(context, 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: _isMobile(context) ? 16 : 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
