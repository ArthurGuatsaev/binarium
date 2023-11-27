import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChartsWidget extends StatefulWidget {
  final String symbol;
  const ChartsWidget({super.key, required this.symbol});

  @override
  State<ChartsWidget> createState() => _ChartsWidgetState();
}

class _ChartsWidgetState extends State<ChartsWidget> {
  @override
  void initState() {
    super.initState();
    inv = '''
<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container" style="height:100%;width:100%">
  <div id="tradingview_2901f" style="height:calc(100% - 32px);width:100%"></div>
  <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "autosize": true,
  "symbol": "OANDA:${widget.symbol}",
  "interval": "30",
  "timezone": "Etc/UTC",
  "theme": "light",
  "style": "1",
  "locale": "en",
  "enable_publishing": false,
  "hide_top_toolbar": true,
  "hide_legend": true,
  "allow_symbol_change": true,
  "save_image": false,
  "hide_volume": true,
  "container_id": "tradingview_2901f"
}
  );
  </script>
</div>
<!-- TradingView Widget END -->
''';
  }

  String inv = '';
  late final controller = WebViewController()..loadHtmlString(inv);

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
