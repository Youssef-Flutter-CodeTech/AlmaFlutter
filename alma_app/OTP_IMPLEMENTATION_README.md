# OTP Implementation with Countdown Timer

This document describes the enhanced OTP (One-Time Password) implementation that includes a countdown timer and resend functionality.

## Features

### 1. Countdown Timer
- **30-second OTP input window**: Users have 30 seconds to enter the 6-digit OTP code
- **Visual countdown**: Shows remaining time in MM:SS format
- **Color-coded urgency**: Timer turns red when 10 seconds or less remain
- **Automatic expiration**: OTP input is disabled after 30 seconds

### 2. Resend Functionality
- **2-minute cooldown**: After OTP expires, users must wait 2 minutes before resending
- **Resend button**: Becomes enabled after the cooldown period
- **Timer display**: Shows remaining time until resend is available

### 3. Enhanced UX
- **Individual digit input boxes**: 6 separate input fields for better user experience
- **Auto-focus**: Automatically moves to next input field when digit is entered
- **Form validation**: Real-time validation and button state management
- **Loading states**: Shows loading indicator during verification
- **Responsive design**: Adapts to different screen sizes

## Implementation Details

### Files Modified

1. **`lib/features/Auth/verifyotp/presentation/widgets/otp_form.dart`**
   - Complete rewrite with timer functionality
   - Individual digit input handling
   - Countdown timer implementation
   - Resend logic

2. **`lib/features/Auth/verifyotp/presentation/pages/verifyotp_page.dart`**
   - Enhanced UI with gradient background
   - Better layout and spacing
   - Support for new OTP form

3. **`assets/lang/en.json`** and **`assets/lang/ar.json`**
   - Added new localization keys for timer messages
   - Support for both English and Arabic

### Timer Logic

```dart
// OTP Timer: 30 seconds
int _otpTimeLeft = 30;

// Resend Cooldown: 2 minutes (120 seconds)
int _resendTimeLeft = 120;

// Timer states
bool _isOtpExpired = false;
bool _canResend = false;
```

### Key Methods

- `_startOtpTimer()`: Starts the 30-second OTP input countdown
- `_startResendTimer()`: Starts the 2-minute resend cooldown
- `_resetTimers()`: Resets all timers when resending OTP
- `_resendOtp()`: Handles OTP resend logic
- `_verifyOtp()`: Handles OTP verification

## Usage

### Basic Implementation

```dart
class VerifyotpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('auth.otp_title'.tr())),
      body: const OtpForm(),
    );
  }
}
```

### Customization

You can customize the timer durations by modifying these values in `otp_form.dart`:

```dart
// Change OTP input window (default: 30 seconds)
int _otpTimeLeft = 30;

// Change resend cooldown (default: 120 seconds)
int _resendTimeLeft = 120;
```

## Localization Keys

### English
- `auth.otp_timer`: "Resend code in {time}"
- `auth.otp_expired`: "Code expired. Please request a new one."
- `auth.resend_disabled`: "Resend in {time}"
- `auth.otp_validation`: "Please enter a valid 6-digit code"
- `auth.please_enter_otp`: "Please enter the OTP code"
- `auth.one_time_password`: "One-Time Password"
- `auth.confirm`: "Confirm"

### Arabic
- `auth.otp_timer`: "إعادة إرسال الرمز في {time}"
- `auth.otp_expired`: "انتهت صلاحية الرمز. يرجى طلب رمز جديد."
- `auth.resend_disabled`: "إعادة الإرسال في {time}"
- `auth.otp_validation`: "يرجى إدخال رمز صحيح مكون من 6 أرقام"
- `auth.please_enter_otp`: "يرجى إدخال رمز التحقق"
- `auth.one_time_password`: "كلمة المرور لمرة واحدة"
- `auth.confirm`: "تأكيد"

## Future Enhancements

1. **API Integration**: Connect to actual OTP verification endpoints
2. **Biometric Support**: Add fingerprint/face ID verification
3. **Voice OTP**: Support for voice-based OTP delivery
4. **Advanced Security**: Rate limiting and fraud detection
5. **Accessibility**: Screen reader support and high contrast modes

## Testing

To test the implementation:

1. Navigate to the OTP verification page
2. Observe the 30-second countdown timer
3. Try entering the OTP code
4. Wait for expiration and observe the 2-minute resend cooldown
5. Test the resend functionality
6. Verify form validation and button states

## Dependencies

- `flutter_bloc`: State management
- `easy_localization`: Internationalization
- `flutter`: Core framework

## Notes

- The implementation uses `Timer.periodic` for countdown functionality
- All timers are properly disposed to prevent memory leaks
- The UI is responsive and works on different screen sizes
- Support for both LTR and RTL languages (English and Arabic)

