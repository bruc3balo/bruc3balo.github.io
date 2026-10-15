import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import 'pages/home.dart';
import 'pages/playground.dart';

/// Root of the site. Each route is pre-rendered to its own static HTML file.
class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Router(routes: [
      Route(path: '/', title: 'Bruce Omukoko | Portfolio', builder: (context, state) => const Home()),
      Route(
        path: '/playground',
        title: 'Skills Playground | Bruce Omukoko',
        builder: (context, state) => const Playground(),
      ),
    ]);
  }
}
