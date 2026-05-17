import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('No withOpacity calls exist in the lib codebase', () {
    // Feature: bmi-app-enhancement, Property 0: No withOpacity
    final directory = Directory('lib');
    final files = directory.listSync(recursive: true).whereType<File>();
    
    final filesWithOpacity = <String>[];
    
    for (final file in files) {
      if (file.path.endsWith('.dart')) {
        final content = file.readAsStringSync();
        // Ignore single line comments or this test itself if it scans test folder
        if (content.contains('withOpacity') && !content.contains('// Ignore withOpacity check')) {
          filesWithOpacity.add(file.path);
        }
      }
    }
    
    expect(
      filesWithOpacity, 
      isEmpty, 
      reason: 'The following files contain deprecated withOpacity calls, please use withValues(alpha: ...):\n${filesWithOpacity.join('\n')}',
    );
  });
}
