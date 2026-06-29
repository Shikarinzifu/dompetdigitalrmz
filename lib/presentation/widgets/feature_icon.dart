import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String tone;
  final double size;
  final double iconSize;

  const FeatureIcon({
    super.key,
    required this.icon,
    this.tone = 'blue',
    this.size = 52,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(size * 0.29),
      ),
      child: Center(
        child: Icon(icon, color: colors[1], size: iconSize),
      ),
    );
  }
}

// Map design icon names to Material icons
class DkgIcons {
  static const IconData home = Icons.home_rounded;
  static const IconData history = Icons.history_rounded;
  static const IconData scan = Icons.qr_code_scanner_rounded;
  static const IconData gift = Icons.redeem_rounded;
  static const IconData user = Icons.person_rounded;
  static const IconData send = Icons.swap_horiz_rounded;
  static const IconData wallet = Icons.account_balance_wallet_rounded;
  static const IconData plus = Icons.add_rounded;
  static const IconData bell = Icons.notifications_rounded;
  static const IconData eye = Icons.visibility_rounded;
  static const IconData eyeOff = Icons.visibility_off_rounded;
  static const IconData shield = Icons.shield_rounded;
  static const IconData shieldCheck = Icons.verified_user_rounded;
  static const IconData check = Icons.check_rounded;
  static const IconData mail = Icons.mark_email_unread_rounded;
  static const IconData lock = Icons.lock_rounded;
  static const IconData phone = Icons.phone_rounded;
  static const IconData copy = Icons.content_copy_rounded;
  static const IconData bank = Icons.account_balance_rounded;
  static const IconData arrowLeft = Icons.arrow_back_ios_new_rounded;
  static const IconData arrowRight = Icons.arrow_forward_ios_rounded;
  static const IconData chevRight = Icons.chevron_right_rounded;
  static const IconData chevDown = Icons.keyboard_arrow_down_rounded;
  static const IconData topup = Icons.add_card_rounded;
  static const IconData bill = Icons.request_quote_rounded;
  static const IconData pulsa = Icons.phone_iphone_rounded;
  static const IconData more = Icons.apps_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData fingerprint = Icons.fingerprint_rounded;
  static const IconData key = Icons.key_rounded;
  static const IconData xcircle = Icons.cancel_rounded;
  static const IconData info = Icons.info_rounded;
  static const IconData qris = Icons.qr_code_2_rounded;
  static const IconData store = Icons.store_rounded;
  static const IconData link = Icons.link_rounded;
  static const IconData clock = Icons.schedule_rounded;
  static const IconData refresh = Icons.refresh_rounded;
  static const IconData settings = Icons.settings_rounded;
  static const IconData logout = Icons.logout_rounded;
  static const IconData star = Icons.star_rounded;
  static const IconData splitBill = Icons.receipt_rounded;
  static const IconData card = Icons.credit_card_rounded;
  static const IconData food = Icons.restaurant_rounded;
  static const IconData smartphone = Icons.phone_android_rounded;
  static const IconData transfer = Icons.swap_horiz_rounded;
  static const IconData bayar = Icons.wallet_rounded;
  static const IconData tarik = Icons.arrow_downward_rounded;
  static const IconData pln = Icons.electric_bolt_rounded;
  static const IconData kantin = Icons.local_dining_rounded;
  static const IconData ukt = Icons.school_rounded;
  static const IconData paketData = Icons.signal_cellular_alt_rounded;
  static const IconData voucher = Icons.redeem_rounded;
  static const IconData donasi = Icons.volunteer_activism_rounded;
  static const IconData lainnya = Icons.grid_view_rounded;
}
