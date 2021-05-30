import 'package:quick_actions/quick_actions.dart';

class ShortCuts {
  static final shortcutItems = <ShortcutItem>[
    actionConcrete,
    actionAbstract,
    actionQuotes,
  ];

  static final actionConcrete =
      const ShortcutItem(type: 'action_concrete', localizedTitle: 'Concrete');
  static final actionAbstract =
      const ShortcutItem(type: 'action_abstract', localizedTitle: 'Abstract');
  static final actionQuotes =
      const ShortcutItem(type: 'action_quotes', localizedTitle: 'Quotes');
}
