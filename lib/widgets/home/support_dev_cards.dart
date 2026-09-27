import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/home/home_page_settings.dart';

/// Helper class to open the sponsor ad link in the user's default browser.
abstract final class SupportDevHelper {
  static const String sponsorUrl = 'https://www.profitableratecpmnetwork.com/gv2qwxiabp?key=db756e8f84642016182b97d8e34a3827';

  static Future<void> openSponsorLink(BuildContext context) async {
    try {
      final uri = Uri.parse(sponsorUrl);
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        // Fallback
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('[SupportDev] Failed to launch sponsor URL: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open browser. Please try again!'),
            backgroundColor: Color(0xFFE50914),
          ),
        );
      }
    }
  }

  static void showWhyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF141721),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: const Color(0xFFFFD700).withValues(alpha: 0.3)),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.favorite_rounded, color: Color(0xFFFFD700), size: 22),
            ),
            const SizedBox(width: 12),
            const Text(
              'Why 1 Click?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: const Text(
          'Flick is completely free with zero subscriptions and zero paywalls.\n\n'
          'I build and maintain this project on my own. Tapping this opens 1 quick sponsor ad in your default browser — every click helps support me so I can keep developing Flick and pay for uni!\n\n'
          'Thank you so much for the support! ❤️',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              openSponsorLink(context);
            },
            icon: const Icon(Icons.bolt_rounded, size: 18),
            label: const Text('Support Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB300),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Option C: Dedicated Hero Spotlight Slide
// ─────────────────────────────────────────────────────────────────────────────

class SupportHeroSlide extends StatefulWidget {
  final double screenWidth;

  const SupportHeroSlide({
    super.key,
    required this.screenWidth,
  });

  @override
  State<SupportHeroSlide> createState() => _SupportHeroSlideState();
}

class _SupportHeroSlideState extends State<SupportHeroSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = widget.screenWidth < 600;
    final heroStyle = HomePageSettings.heroStyle.value;

    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Rich cinematic dark gradient with warm gold & purple ambient glows ──
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.4, -0.3),
              radius: 1.2,
              colors: [
                Color(0xFF2A1F0A), // Warm dark amber
                Color(0xFF140F1E), // Deep royal violet
                Color(0xFF080A0F), // App dark background
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
        ),

        // ── Decorative background graphic elements ──
        Positioned(
          right: isCompact ? -40 : 60,
          top: isCompact ? 60 : 40,
          bottom: isCompact ? 60 : 40,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, _) {
              final scale = 0.95 + (_pulseController.value * 0.1);
              final opacity = 0.12 + (_pulseController.value * 0.08);

              return Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: isCompact ? 220 : 380,
                    height: isCompact ? 220 : 380,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFFD700).withValues(alpha: 0.6),
                          const Color(0xFFFF8F00).withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.diamond_rounded,
                        size: isCompact ? 140 : 240,
                        color: const Color(0xFFFFD700).withValues(alpha: 0.35),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Left horizontal wash for cinematic readability
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.0, 0.45, 0.9],
                colors: [
                  const Color(0xFF080A0F).withValues(alpha: 0.95),
                  const Color(0xFF080A0F).withValues(alpha: 0.75),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Bottom gradient into body
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.0, 0.35, 0.7],
                colors: [
                  const Color(0xFF080A0F),
                  const Color(0xFF080A0F).withValues(alpha: 0.85),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // ── Main Slide Content ──
        Positioned(
          left: isCompact ? 20 : 48,
          right: isCompact ? 20 : 48,
          bottom: isCompact
              ? (heroStyle == HeroStyle.minimalist ? 18 : 32)
              : (heroStyle == HeroStyle.minimalist ? 28 : 50),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isCompact ? double.infinity : 720.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Pill / Badge
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0x38FFD700),
                              Color(0x1FFF8F00),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFFFD700).withValues(alpha: 0.45),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFD700).withValues(alpha: 0.25),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt_rounded, size: 16, color: Color(0xFFFFD700)),
                            SizedBox(width: 5),
                            Text(
                              'SUPPORT THE DEV • \$0 SUBSCRIPTION',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFFFD700),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: isCompact ? 10 : 14),

                  // Catchy Main Title in Playfair Display (Semi-Bold Italic)
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFFFF2A1),
                        Color(0xFFFFD700),
                        Color(0xFFFFA000),
                      ],
                    ).createShader(bounds),
                    child: Text(
                      'Why pay \$22/mo for Netflix when 1 click keeps Flick free?',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        fontSize: isCompact
                            ? 22.0
                            : (widget.screenWidth < 1100 ? 32.0 : 38.0),
                        height: 1.18,
                        letterSpacing: -0.3,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Subtext
                  if (heroStyle != HeroStyle.minimalist) ...[
                    SizedBox(height: isCompact ? 8 : 12),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isCompact ? double.infinity : 600,
                      ),
                      child: Text(
                        'Takes 5 seconds. Opens 1 sponsor ad in your browser. Zero subscriptions forever. Every click directly supports me to keep developing Flick and pay for uni.',
                        maxLines: heroStyle == HeroStyle.compact ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: isCompact ? 13.0 : 15.0,
                          color: Colors.white.withValues(alpha: 0.75),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],

                  // Action Buttons
                  SizedBox(height: isCompact ? 16 : 22),
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // Big Shiny Glowing Button
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          final glow = 8.0 + (_pulseController.value * 8.0);
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFFB300)
                                      .withValues(alpha: 0.45 + (_pulseController.value * 0.25)),
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
                          icon: const Icon(Icons.bolt_rounded, size: 20),
                          label: const Text(
                            'Support Dev with 1 Ad ✨',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14.5,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB300),
                            foregroundColor: const Color(0xFF160F02),
                            padding: EdgeInsets.symmetric(
                              horizontal: isCompact ? 18 : 24,
                              vertical: isCompact ? 12 : 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),

                      // Secondary "Why 1 Click?"
                      OutlinedButton.icon(
                        onPressed: () => SupportDevHelper.showWhyDialog(context),
                        icon: Icon(
                          Icons.help_outline_rounded,
                          size: 18,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        label: Text(
                          'Why 1 Click?',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: isCompact ? 13 : 14,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: isCompact ? 14 : 18,
                            vertical: isCompact ? 12 : 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.22),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// In-Feed Poster Card (Nestled between cards in the first slider)
// ─────────────────────────────────────────────────────────────────────────────

class SupportSliderCard extends StatefulWidget {
  final double cardWidth;

  const SupportSliderCard({
    super.key,
    required this.cardWidth,
  });

  @override
  State<SupportSliderCard> createState() => _SupportSliderCardState();
}

class _SupportSliderCardState extends State<SupportSliderCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _pressed = false;
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posterHeight = widget.cardWidth * 1.48;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) {
        setState(() {
          _hovered = false;
          _pressed = false;
        });
      },
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: () => SupportDevHelper.openSponsorLink(context),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeOutCubic,
          scale: _pressed ? 0.97 : (_hovered ? HomePageSettings.cardHoverZoom.value : 1.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 170),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Poster Equivalent Frame ──────────────────────────────────
                SizedBox(
                  width: widget.cardWidth,
                  height: posterHeight,
                  child: AnimatedBuilder(
                    animation: _glowController,
                    builder: (context, child) {
                      final glowOpacity = 0.35 + (_glowController.value * 0.35);

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF261A07), // Deep amber-black
                              Color(0xFF14101A), // Dark purple-black
                              Color(0xFF0C0E14), // Dark base
                            ],
                          ),
                          border: Border.all(
                            color: Color.lerp(
                              const Color(0xFFFFD700).withValues(alpha: 0.5),
                              const Color(0xFFFF9100).withValues(alpha: 0.8),
                              _glowController.value,
                            )!,
                            width: _hovered ? 2.0 : 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFB300).withValues(alpha: glowOpacity),
                              blurRadius: _hovered ? 18 : 12,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: child,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          // Background glowing orb
                          Positioned(
                            top: -20,
                            right: -20,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFFFD700).withValues(alpha: 0.15),
                              ),
                            ),
                          ),

                          // Card Contents
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Top badge
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFD700).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.bolt_rounded, size: 12, color: Color(0xFFFFD700)),
                                      SizedBox(width: 3),
                                      Text(
                                        '100% FREE',
                                        style: TextStyle(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFFFFD700),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),

                                // Center Icon / Heart
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFFFFD700).withValues(alpha: 0.12),
                                      border: Border.all(
                                        color: const Color(0xFFFFD700).withValues(alpha: 0.25),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.favorite_rounded,
                                      color: Color(0xFFFFD700),
                                      size: 32,
                                    ),
                                  ),
                                ),

                                const Spacer(),

                                // Catchy Title in Playfair Display
                                Text(
                                  'Skip the \$22 Bill.',
                                  style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w700,
                                    fontSize: widget.cardWidth < 160 ? 15 : 17,
                                    color: const Color(0xFFFFF0A6),
                                    height: 1.15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '1 quick click supports the dev & uni.',
                                  style: TextStyle(
                                    fontSize: widget.cardWidth < 160 ? 10.5 : 11.5,
                                    color: Colors.white70,
                                    height: 1.25,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10),

                                // Bottom CTA button / pill
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFFFB300), Color(0xFFFF8F00)],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFFB300).withValues(alpha: 0.4),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Support Dev ✨',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF160F02),
                                      ),
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
                ),

                const SizedBox(height: 8),

                // ── Card Title below Poster ──────────────────────────────────
                const Text(
                  'Support The Developer',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '1 Click • Help Pay for Uni',
                  style: TextStyle(
                    color: const Color(0xFFFFD700).withValues(alpha: 0.8),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
