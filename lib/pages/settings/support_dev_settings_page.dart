import 'package:flutter/material.dart';

import '../../services/home/home_page_settings.dart';
import '../../widgets/home/support_dev_cards.dart';

class SupportDevSettingsPage extends StatefulWidget {
  const SupportDevSettingsPage({super.key});

  @override
  State<SupportDevSettingsPage> createState() => _SupportDevSettingsPageState();
}

class _SupportDevSettingsPageState extends State<SupportDevSettingsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1017),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Support Flick',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              // ── 1. Hero Showcase & Instant Support Button ──
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const RadialGradient(
                    center: Alignment(0.7, -0.4),
                    radius: 1.3,
                    colors: [
                      Color(0xFF2B1D08), // Warm dark amber
                      Color(0xFF140F1F), // Deep violet
                      Color(0xFF0F121A), // Dark slate
                    ],
                    stops: [0.0, 0.55, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFFFD700).withValues(alpha: 0.35),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFB300).withValues(alpha: 0.12),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt_rounded, size: 15, color: Color(0xFFFFD700)),
                          SizedBox(width: 5),
                          Text(
                            'SUPPORT THE DEVELOPER',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFFFD700),
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Title in Playfair Display (Italic)
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFFFF2A1),
                          Color(0xFFFFD700),
                          Color(0xFFFFA000),
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        'Why pay \$22/mo for Netflix when 1 click keeps Flick free?',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          height: 1.25,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Flick has zero subscriptions, zero paywalls, and no paid tiers. I build and maintain this app entirely on my own.\n\n'
                      'Tapping the button below opens 1 quick sponsor ad in your default browser. Each click gives a few cents to support me directly so I can keep going and pay for uni!',
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.white.withValues(alpha: 0.75),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Big Shiny Action Button
                    AnimatedBuilder(
                      animation: _glowController,
                      builder: (context, child) {
                        final glow = 8.0 + (_glowController.value * 10.0);
                        final alpha = 0.4 + (_glowController.value * 0.3);

                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFB300).withValues(alpha: alpha),
                                blurRadius: glow,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: child,
                        );
                      },
                      child: ElevatedButton.icon(
                        onPressed: () => SupportDevHelper.openSponsorLink(context),
                        icon: const Icon(Icons.bolt_rounded, size: 22),
                        label: const Text(
                          'Support Dev with 1 Ad ✨',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15.5,
                            letterSpacing: 0.3,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFB300),
                          foregroundColor: const Color(0xFF160F02),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Center(
                      child: Text(
                        'Opens a sponsor ad link safely in your system default browser',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // ── 2. Visibility & Home Page Controls ──
              Text(
                'HOME PAGE DISPLAY PREFERENCES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.35),
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF12151E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: ValueListenableBuilder<bool>(
                  valueListenable: HomePageSettings.enableSupportDev,
                  builder: (context, enabled, _) {
                    return Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB300).withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                            color: Color(0xFFFFB300),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Show Support Cards on Home Page',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Includes the Spotlight hero banner slide & the card after Continue Watching',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Switch.adaptive(
                          value: enabled,
                          onChanged: (val) {
                            HomePageSettings.setEnableSupportDev(val);
                            setState(() {});
                          },
                          activeColor: const Color(0xFFFFB300),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 26),

              // ── 3. FAQ / Transparency Section ──
              Text(
                'TRANSPARENCY & INFORMATION',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.35),
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF12151E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: Column(
                  children: [
                    _buildFaqItem(
                      question: 'Does supporting cost me anything?',
                      answer: 'No. It costs you \$0. You never pay a single cent for Flick.',
                    ),
                    Divider(color: Colors.white.withValues(alpha: 0.06), height: 24),
                    _buildFaqItem(
                      question: 'What happens when I click the button?',
                      answer: 'It opens 1 sponsor ad page in your external browser. That single visit generates a small ad credit that directly supports me to keep working on Flick and pay for uni.',
                    ),
                    Divider(color: Colors.white.withValues(alpha: 0.06), height: 24),
                    _buildFaqItem(
                      question: 'Can I disable the home page prompts?',
                      answer: 'Yes! Toggle the switch above off and all support slides and in-feed cards are instantly hidden.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.help_outline_rounded, color: Color(0xFFFFB300), size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                answer,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
