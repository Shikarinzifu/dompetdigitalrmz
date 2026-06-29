import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../blocs/account/account_bloc.dart';
import '../../blocs/payment/payment_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_top_bar.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});
  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final _amountCtrl = TextEditingController();
  final _focusNode = FocusNode();
  double _selectedAmount = 0;

  final _chips = [50000.0, 100000.0, 200000.0, 500000.0, 1000000.0];

  @override
  void dispose() {
    _amountCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentTopupSuccess) {
          context.go('/success', extra: {
            'title': 'Penarikan berhasil',
            'subtitle': 'Saldo kamu berkurang',
            'amount': state.amount,
            'lines': [
              ['Metode', 'Transfer Bank'],
              ['Saldo sekarang', CurrencyFormatter.format(state.balance)],
            ],
          });
        } else if (state is PaymentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: AppColors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bg,
        appBar: AppTopBar(title: 'Tarik Tunai', onBack: () => context.go('/home')),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─── Saldo info ───
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        final balance = state is AccountLoaded ? state.account.balance : 0.0;
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: AppColors.shadowSoft,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.account_balance_wallet_outlined,
                                  size: 22, color: AppColors.primary),
                              const SizedBox(width: 10),
                              const Text('Saldo tersedia',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 13,
                                    color: AppColors.slate500,
                                  )),
                              const Spacer(),
                              Text(CurrencyFormatter.format(balance),
                                  style: const TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.ink,
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // ─── Nominal penarikan ───
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 10),
                      child: Text('Nominal penarikan',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate400,
                          )),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: _chips.map((c) {
                        final selected = _selectedAmount == c;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAmount = c;
                              _amountCtrl.text = c.toInt().toString();
                            });
                            _focusNode.unfocus();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            decoration: BoxDecoration(
                              color: selected ? AppColors.primarySurface : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: selected ? AppColors.primaryLight : AppColors.line,
                                width: 1.8,
                              ),
                            ),
                            child: Center(
                              child: Text(CurrencyFormatter.format(c),
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: selected ? AppColors.primary : AppColors.ink,
                                  )),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // ─── Custom amount ───
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 10),
                      child: Text('Atau masukkan nominal',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate400,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppColors.shadowSoft,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Row(
                        children: [
                          const Text('Rp',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.slate400,
                              )),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _amountCtrl,
                              focusNode: _focusNode,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ink,
                              ),
                              decoration: const InputDecoration(
                                hintText: '0',
                                hintStyle: TextStyle(color: AppColors.line),
                                border: InputBorder.none,
                              ),
                              onChanged: (v) {
                                final parsed = double.tryParse(v) ?? 0;
                                setState(() {
                                  _selectedAmount = parsed;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ─── Warning ───
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, size: 18, color: Colors.orange),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Penarikan akan dikurangi dari saldo kamu secara langsung.',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 12,
                                color: AppColors.slate600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: AppColors.bg,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              child: BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  final amount = _selectedAmount > 0
                      ? _selectedAmount
                      : (double.tryParse(_amountCtrl.text) ?? 0);
                  return AppButton(
                    label: 'Tarik ${CurrencyFormatter.format(amount)}',
                    isLoading: state is PaymentLoading,
                    onPressed: amount > 0
                        ? () {
                            context.read<PaymentBloc>().add(
                                  PaymentWithdrawRequested(amount),
                                );
                          }
                        : null,
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
