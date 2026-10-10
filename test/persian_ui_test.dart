import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_ui/persian_ui.dart';

void main() {
  // ===========================================================================
  // Foundation - PColors
  // ===========================================================================

  group('PColors', () {
    test('should expose expected brand colors', () {
      expect(PColors.primary, const Color(0xFF1976D2));
      expect(PColors.primaryDark, const Color(0xFF1259A7));
      expect(PColors.primaryLight, const Color(0xFFE3F2FD));
    });

    test('should expose expected semantic colors', () {
      expect(PColors.success, const Color(0xFF2E7D32));
      expect(PColors.warning, const Color(0xFFED6C02));
      expect(PColors.error, const Color(0xFFD32F2F));
      expect(PColors.info, const Color(0xFF0288D1));
    });

    test('should expose expected neutral colors', () {
      expect(PColors.white, const Color(0xFFFFFFFF));
      expect(PColors.black, const Color(0xFF000000));
      expect(PColors.background, const Color(0xFFF8F9FA));
      expect(PColors.surface, const Color(0xFFFFFFFF));
      expect(PColors.surfaceVariant, const Color(0xFFF1F3F5));
      expect(PColors.border, const Color(0xFFDEE2E6));
      expect(PColors.divider, const Color(0xFFE9ECEF));
    });

    test('should expose expected text colors', () {
      expect(PColors.textPrimary, const Color(0xFF212529));
      expect(PColors.textSecondary, const Color(0xFF6C757D));
      expect(PColors.textDisabled, const Color(0xFFADB5BD));
      expect(PColors.textOnPrimary, const Color(0xFFFFFFFF));
    });
  });

  // ===========================================================================
  // Foundation - PSpacing
  // ===========================================================================

  group('PSpacing', () {
    test('should expose expected spacing tokens', () {
      expect(PSpacing.none, 0.0);
      expect(PSpacing.xxs, 2.0);
      expect(PSpacing.xs, 4.0);
      expect(PSpacing.sm, 8.0);
      expect(PSpacing.md, 12.0);
      expect(PSpacing.lg, 16.0);
      expect(PSpacing.xl, 24.0);
      expect(PSpacing.xxl, 32.0);
      expect(PSpacing.xxxl, 48.0);
    });
  });

  // ===========================================================================
  // Foundation - PRadius
  // ===========================================================================

  group('PRadius', () {
    test('should expose expected radius tokens', () {
      expect(PRadius.none, 0.0);
      expect(PRadius.sm, 4.0);
      expect(PRadius.md, 8.0);
      expect(PRadius.lg, 12.0);
      expect(PRadius.xl, 16.0);
      expect(PRadius.xxl, 24.0);
      expect(PRadius.full, 999.0);
    });
  });

  // ===========================================================================
  // Foundation - PTypography
  // ===========================================================================

  group('PTypography', () {
    test('should expose expected font sizes', () {
      expect(PTypography.fontSizeXs, 12.0);
      expect(PTypography.fontSizeSm, 14.0);
      expect(PTypography.fontSizeMd, 16.0);
      expect(PTypography.fontSizeLg, 18.0);
      expect(PTypography.fontSizeXl, 20.0);
      expect(PTypography.fontSizeXxl, 24.0);
      expect(PTypography.fontSizeDisplay, 32.0);
    });

    test('should expose expected font weights', () {
      expect(PTypography.regular, FontWeight.w400);
      expect(PTypography.medium, FontWeight.w500);
      expect(PTypography.semiBold, FontWeight.w600);
      expect(PTypography.bold, FontWeight.w700);
    });
  });

  // ===========================================================================
  // Theme
  // ===========================================================================

  group('PersianTheme', () {
    test('light theme should use Material 3', () {
      final ThemeData theme = PersianTheme.light();

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.light);
    });

    test('dark theme should use Material 3', () {
      final ThemeData theme = PersianTheme.dark();

      expect(theme.useMaterial3, isTrue);
      expect(theme.brightness, Brightness.dark);
    });

    test('light theme should use PersianUI background color', () {
      final ThemeData theme = PersianTheme.light();

      expect(theme.scaffoldBackgroundColor, PColors.background);
      expect(theme.dividerColor, PColors.divider);
      expect(theme.cardColor, PColors.surface);
    });
  });

}