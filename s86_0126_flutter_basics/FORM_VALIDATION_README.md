# Form Validation in Flutter - Complete Assignment

## Overview

This document explains how form validation works in Flutter for the Community Sports Tournaments App. Forms are critical for collecting user data in authentication, registration, profiles, and bookings.

## Table of Contents
1. Why Form Validation Matters
2. Basic Form Structure
3. Validators and Error Handling
4. Common Validation Patterns
5. Advanced Form Validation
6. Best Practices
7. Implementation Examples

---

## 1. Why Form Validation Is Important

Form validation:
- **Prevents Invalid Data**: Ensures only properly formatted data is submitted
- **Improves UX**: Provides immediate feedback to users about errors
- **Protects Backend**: Prevents malformed or malicious input from reaching servers
- **Enforces Business Logic**: Ensures data meets application requirements
- **Enhances Security**: Validates sensitive fields like passwords and emails

### Real-World Scenarios in Sports Tournament App:
- User registration with email verification
- Tournament sign-up with phone number validation
- Payment information with card details
- Profile updates with address validation
- Team creation with team name rules

---

## 2. Basic Form Structure in Flutter

### Core Components

```dart
// 1. Form widget with GlobalKey
final _formKey = GlobalKey<FormState>();

// 2. TextFormField for individual inputs
TextFormField(
  controller: _nameController,
  validator: (value) {
    if (value?.isEmpty) return "Required field";
    return null;
  },
)

// 3. Validate and submit
if (_formKey.currentState!.validate()) {
  // Form is valid, process data
}
```

### Form Lifecycle

```
FormState Methods:
├── validate() → Runs all validators, returns true if all valid
├── reset() → Clears all fields and error messages
├── save() → Saves form values (optional, use controllers instead)
└── currentState → Access current form state
```

### Complete Basic Form Example

```dart
class BasicFormExample extends StatefulWidget {
  @override
  State<BasicFormExample> createState() => _BasicFormExampleState();
}

class _BasicFormExampleState extends State<BasicFormExample> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("Form is valid!");
      print("Name: ${_nameController.text}");
      print("Email: ${_emailController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Name"),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Name is required";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Email is required";
              }
              if (!value!.contains("@")) {
                return "Enter valid email";
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
```

---

## 3. Validators and Error Handling

### Built-in Validators

```dart
// Required field
validator: (value) {
  if (value == null || value.isEmpty) {
    return "This field is required";
  }
  return null;
}

// Length validation
validator: (value) {
  if ((value ?? "").length < 8) {
    return "Minimum 8 characters required";
  }
  return null;
}

// Custom validator pattern
validator: (value) {
  if (customCondition(value)) {
    return "Error message";
  }
  return null; // null means no error
}
```

### Displaying Error Messages

Errors display automatically below TextFormField:

```dart
TextFormField(
  decoration: InputDecoration(
    labelText: "Email",
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    errorStyle: TextStyle(color: Colors.red),
  ),
  validator: (value) {
    if (!value!.contains("@")) {
      return "Invalid email format";
    }
    return null;
  },
)
```

### Real-time Validation

Show errors immediately as user types:

```dart
TextFormField(
  controller: _emailController,
  onChanged: (value) {
    _formKey.currentState?.validate();
  },
  validator: _validateEmail,
)
```

---

## 4. Common Validation Patterns

### Email Validation

```dart
String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Email is required";
  }
  
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );
  
  if (!emailRegex.hasMatch(value)) {
    return "Enter a valid email address";
  }
  
  return null;
}
```

### Password Validation (Basic)

```dart
String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }
  
  if (value.length < 8) {
    return "Password must be at least 8 characters";
  }
  
  return null;
}
```

### Password Validation (Advanced)

```dart
String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }
  
  if (value.length < 8) {
    return "Minimum 8 characters required";
  }
  
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return "Must contain lowercase letters";
  }
  
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return "Must contain uppercase letters";
  }
  
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return "Must contain numbers";
  }
  
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return "Must contain special characters (!@#$%^&*)";
  }
  
  return null;
}
```

### Phone Number Validation

```dart
String? _validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return "Phone number is required";
  }
  
  // Remove formatting characters
  final cleanedPhone = value.replaceAll(RegExp(r'[\s\-+()]'), '');
  
  if (!RegExp(r'^[0-9]{10,15}$').hasMatch(cleanedPhone)) {
    return "Enter a valid phone number (10-15 digits)";
  }
  
  return null;
}
```

### Name Validation

```dart
String? _validateName(String? value) {
  if (value == null || value.isEmpty) {
    return "Name is required";
  }
  
  if (value.length < 2) {
    return "Name must be at least 2 characters";
  }
  
  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
    return "Name can only contain letters and spaces";
  }
  
  return null;
}
```

### Address Validation

```dart
String? _validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return "Address is required";
  }
  
  if (value.length < 10) {
    return "Address must be at least 10 characters";
  }
  
  return null;
}
```

---

## 5. Advanced Form Validation

### Cross-Field Validation (Password Confirmation)

```dart
String? _password;

TextFormField(
  key: ValueKey('password'),
  controller: _passwordController,
  obscureText: true,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    _password = value; // Store for comparison
    return null;
  },
),

TextFormField(
  key: ValueKey('confirmPassword'),
  controller: _confirmPasswordController,
  obscureText: true,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Please confirm password";
    }
    
    if (value != _password) {
      return "Passwords do not match";
    }
    
    return null;
  },
)
```

### Conditional Validation

```dart
String? _validateTeamSize(String? value) {
  if (value == null || value.isEmpty) {
    return "Team size is required";
  }
  
  int? size = int.tryParse(value);
  
  if (size == null) {
    return "Enter a number";
  }
  
  // Different validation based on selected sport
  if (_selectedSport == "Basketball" && size != 5) {
    return "Basketball teams must have 5 players";
  }
  
  if (_selectedSport == "Football" && size != 11) {
    return "Football teams must have 11 players";
  }
  
  return null;
}
```

### Custom Validators

```dart
typedef FormFieldValidator<T> = String? Function(T? value);

class CustomValidators {
  // Email validator
  static String? email(String? value) {
    return value?.contains("@") ?? false ? null : "Invalid email";
  }
  
  // Password strength validator
  static String? passwordStrength(String? value) {
    int strength = 0;
    if ((value ?? "").length >= 8) strength++;
    if (RegExp(r'[a-z]').hasMatch(value ?? "")) strength++;
    if (RegExp(r'[A-Z]').hasMatch(value ?? "")) strength++;
    if (RegExp(r'[0-9]').hasMatch(value ?? "")) strength++;
    if (RegExp(r'[^a-zA-Z0-9]').hasMatch(value ?? "")) strength++;
    
    if (strength < 4) return "Password too weak";
    return null;
  }
  
  // URL validator
  static String? url(String? value) {
    if (value == null || value.isEmpty) return null;
    
    final urlRegex = RegExp(
      r'^(https?|ftp)://[^\s/$.?#].[^\s]*$',
      caseSensitive: false
    );
    
    return urlRegex.hasMatch(value) ? null : "Invalid URL";
  }
}
```

### Multi-Step Form Validation

```dart
class MultiStepForm extends StatefulWidget {
  @override
  State<MultiStepForm> createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  late PageController _pageController;
  int _currentStep = 0;
  
  final _personalFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  void _nextStep() {
    // Validate current step
    late GlobalKey<FormState> currentKey;
    
    switch (_currentStep) {
      case 0:
        currentKey = _personalFormKey;
        break;
      case 1:
        currentKey = _addressFormKey;
        break;
      case 2:
        currentKey = _paymentFormKey;
        break;
    }
    
    if (currentKey.currentState!.validate()) {
      if (_currentStep < 2) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // All steps valid, submit form
        _submitForm();
      }
    }
  }

  void _submitForm() {
    print("All steps validated - submit form");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() => _currentStep = page);
        },
        children: [
          // Step 1: Personal Info
          Form(
            key: _personalFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Full Name"),
                  validator: _validateName,
                ),
              ],
            ),
          ),
          // Step 2: Address
          Form(
            key: _addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Address"),
                  validator: _validateAddress,
                ),
              ],
            ),
          ),
          // Step 3: Payment
          Form(
            key: _paymentFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Card Number"),
                  validator: _validateCardNumber,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextStep,
        child: Icon(_currentStep == 2 ? Icons.check : Icons.arrow_forward),
      ),
    );
  }
}
```

---

## 6. Best Practices

### ✅ DO's

1. **Always dispose controllers**
   ```dart
   @override
   void dispose() {
     _nameController.dispose();
     _emailController.dispose();
     super.dispose();
   }
   ```

2. **Use meaningful error messages**
   ```dart
   // Good
   return "Password must be at least 8 characters";
   
   // Bad
   return "Invalid password";
   ```

3. **Validate on both change and submit**
   ```dart
   TextFormField(
     onChanged: (value) => _formKey.currentState?.validate(),
     validator: _validateEmail,
   )
   ```

4. **Use GlobalKey for form validation**
   ```dart
   final _formKey = GlobalKey<FormState>();
   ```

5. **Provide visual feedback**
   ```dart
   errorBorder: OutlineInputBorder(
     borderSide: BorderSide(color: Colors.red, width: 2),
   ),
   focusedBorder: OutlineInputBorder(
     borderSide: BorderSide(color: Colors.blue, width: 2),
   ),
   ```

### ❌ DON'Ts

1. **Don't use TextField for validation** → Use TextFormField
2. **Don't forget to dispose controllers** → Causes memory leaks
3. **Don't validate only on submit** → Give real-time feedback
4. **Don't show generic errors** → Be specific about what's wrong
5. **Don't trust client-side validation alone** → Always validate server-side
6. **Don't put complex logic in validators** → Keep validators simple and fast

---

## 7. Implementation Examples in This Project

### Tournament Registration Form (`user_input_form.dart`)

This form demonstrates:
- ✅ Name validation (letters and spaces only)
- ✅ Email validation (proper format)
- ✅ Phone number validation (10-15 digits)
- ✅ Team name validation
- ✅ Dropdown selection validation
- ✅ Real-time validation feedback
- ✅ Success/error SnackBars
- ✅ Form reset capability

**Features:**
- Sports selection dropdown
- Experience level dropdown
- Newsletter subscription checkbox
- Confirmation dialog on success
- Responsive design

### Advanced Form (`advanced_form_screen.dart`)

This form demonstrates advanced concepts:
- ✅ Strong password validation (uppercase, lowercase, numbers, special chars)
- ✅ Password confirmation (cross-field validation)
- ✅ Multiple field types (text, password, dropdown, checkbox)
- ✅ Real-time validation with visual feedback
- ✅ Password visibility toggle
- ✅ Terms and conditions agreement
- ✅ Advanced error messages with requirements

**Features:**
- Full name validation
- Email validation
- Strong password requirements
- Password confirmation matching
- Phone number validation
- Address validation (minimum length)
- Gender selection
- Terms agreement requirement
- All validation feedback real-time

---

## Summary

Form validation in Flutter ensures:
1. **Data Quality**: Only valid data is submitted
2. **User Experience**: Clear, immediate feedback
3. **Security**: Input sanitization and validation
4. **Accessibility**: Helpful error messages

### Key Takeaways:
- Use `Form` + `GlobalKey<FormState>` + `TextFormField`
- Write clear validators with meaningful error messages
- Validate on both change (real-time) and submit
- Handle cross-field validation for dependent fields
- Always dispose controllers to prevent memory leaks
- Perform server-side validation as well (critical!)
- Keep validators simple and focused
- Provide excellent UX with visual and text feedback

### Resources Used:
- Flutter Form widget documentation
- TextFormField validators
- Regular expressions for pattern matching
- Custom validation functions
- Best practices from Flutter community

---

**Last Updated:** February 13, 2026
**Project:** s86_0126_flutter_basics - Community Sports Tournaments App
