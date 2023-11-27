import 'package:binarium/models/term.dart';
import 'package:binarium/onboard/onbord/widgets/base_onb.dart';
import 'package:binarium/repositories/navigation/nav_manager.dart';
import 'package:flutter/cupertino.dart';

const String appName = 'Binarium';
const Map<String, String> valute = {
  'EUR/USD': 'EURUSD',
  'USD/JPY': 'USDJPY',
  'GBP/USD': 'GBPUSD',
  'AUD/USD': 'AUDUSD',
  'USD/CAD': 'USDCAD'
};
final Map<String, Widget> flags = {
  'EURUSD': Image.asset(
    'assets/images/EURUSD.png',
    width: 50,
    height: 50,
  ),
  'USDJPY': Image.asset(
    'assets/images/JPNUSD.png',
    width: 50,
  ),
  'GBPUSD': Image.asset(
    'assets/images/GBRUSD.png',
    width: 50,
  ),
  'AUDUSD': Image.asset(
    'assets/images/AUSUSD.png',
    width: 50,
  ),
  'USDCAD': Image.asset(
    'assets/images/CNDUSD.png',
    width: 50,
  )
};
final Map<String, Widget> fromToFlags = {
  'EUR': Image.asset(
    'assets/images/eur.png',
    width: 50,
    height: 50,
  ),
  'JPY': Image.asset(
    'assets/images/jpy.png',
    width: 50,
  ),
  'GBP': Image.asset(
    'assets/images/gbr.png',
    width: 50,
  ),
  'AUD': Image.asset(
    'assets/images/aud.png',
    width: 50,
  ),
  'CAD': Image.asset(
    'assets/images/cad.png',
    width: 50,
  ),
  'USD': Image.asset(
    'assets/images/usa.png',
    width: 50,
  )
};

final listFlags = [
  Image.asset(
    'assets/images/EURUSD.png',
    width: 30,
  ),
  Image.asset(
    'assets/images/JPNUSD.png',
    width: 30,
  ),
  Image.asset(
    'assets/images/GBRUSD.png',
    width: 30,
  ),
  Image.asset(
    'assets/images/AUSUSD.png',
    width: 30,
  ),
  Image.asset(
    'assets/images/CNDUSD.png',
    width: 30,
  ),
];

final List<Terms> termsListInitial = [
  Terms(
      name: 'Broker',
      rightDescription:
          'This is the entity that lets you buy and sell investments for you. Usually, you pay a fee for this service. There are also plenty of online discount brokers, where you often pay a flat commission per trade',
      wrongDescription:
          'When an employee leaves his or her employer, he or she can opt to roll over the 401(k) balance and have it deposited into a Rollover IRA, which basically is exactly like the Traditional IRA. I have one of these in Vanguard'),
  Terms(
      name: 'Brokerage Account',
      rightDescription:
          'A brokerage account is created by a licensed brokerage firm, that allows an investor to add funds and then the investor can place investment orders. The investor owns the assets contained in the brokerage account but will usually have to claim any taxable income from capital gains',
      wrongDescription:
          'A type of IRA for small business owners with fewer than 100 employees who want to offer some sort of retirement benefits to their employees but don’t want to deal with larger challenges that come with a 401k company'),
  Terms(
      name: 'Money Market',
      rightDescription:
          'A money market account is an interest-bearing account that will typically pay a higher interest rate than a bank savings account would. I actually store a significant portion of my savings in this for a much better monthly return, than the 0.001% interest of my bank',
      wrongDescription:
          'This form of IRA can be used by self-employed people and small business owners under certain circumstances. The contribution limits are much higher than a Traditional IRA or Roth IRA'),
  Terms(
      name: 'Traditional IRA',
      rightDescription:
          'A traditional IRA is an individual retirement account that offers tax advantages to savers. You won’t pay taxes upfront, but you will when you withdraw during retirement. Traditional IRAs offer tax deductions of up to \$5,500 a year (\$6,500 for those 50 and older)',
      wrongDescription:
          'A brokerage account is created by a licensed brokerage firm, that allows an investor to add funds and then the investor can place investment orders. The investor owns the assets contained in the brokerage account but will usually have to claim any taxable income from capital gains'),
  Terms(
      name: 'Roth IRA',
      rightDescription:
          'An individual retirement account allowing a person to set aside after-tax income. Similar to the Traditional IRA. you can contribute the maximum of \$5,500 to a Roth IRA (\$6,500 if you are age 50 or older by the end of the year). The difference is you are not taxed when you take your retirement payments. However, there are limitations pending your salary',
      wrongDescription:
          'This is the entity that lets you buy and sell investments for you. Usually, you pay a fee for this service. There are also plenty of online discount brokers, where you often pay a flat commission per trade'),
  Terms(
      name: 'SEP-IRA',
      rightDescription:
          'This form of IRA can be used by self-employed people and small business owners under certain circumstances. The contribution limits are much higher than a Traditional IRA or Roth IRA',
      wrongDescription:
          'When an employee leaves his or her employer, he or she can opt to roll over the 401(k) balance and have it deposited into a Rollover IRA, which basically is exactly like the Traditional IRA. I have one of these in Vanguard'),
  Terms(
      name: 'Simple IRA',
      rightDescription:
          'A type of IRA for small business owners with fewer than 100 employees who want to offer some sort of retirement benefits to their employees but don’t want to deal with larger challenges that come with a 401k company',
      wrongDescription:
          'This tax-advantage plan is designed to save for future education costs. This can be for K-12 tuition or for future college costs. There are two types of 529 plans'),
  Terms(
      name: 'Bond',
      rightDescription:
          'A bond is a fixed income investment in which an investor loans money typically corporate or governmental which borrows the funds for a defined period of time at a variable or fixed interest rate. There are many types of bonds out there',
      wrongDescription:
          'Real estate is property, such as land, houses, buildings, or garages that the owner can use or allow others to use in exchange for payment in rent. These properties can also be flipped for profit as well.'),
  Terms(
      name: 'Stocks',
      rightDescription:
          'A stock (also known as “shares” and “equity) is a type of security that signifies ownership in a corporation and represents a claim on part of the corporation’s assets and earnings. There are two main types of stock: common and preferred. Feel free to Google those if interested',
      wrongDescription:
          'A retirement plan that is pretty much like a 401(k) but is only offered for non-profit organizations.'),
  Terms(
      name: 'Real Estate',
      rightDescription:
          'Real estate is property, such as land, houses, buildings, or garages that the owner can use or allow others to use in exchange for payment in rent. These properties can also be flipped for profit as well',
      wrongDescription:
          'A stock (also known as “shares” and “equity) is a type of security that signifies ownership in a corporation and represents a claim on part of the corporation’s assets and earnings. There are two main types of stock: common and preferred. Feel free to Google those if interested'),
  Terms(
      name: 'ETF',
      rightDescription:
          'Or exchange-traded funds are like mutual funds, except that they trade throughout the day on stock exchanges as if they were individual stocks. These ETFs can hold various assets like stocks, commodities, or bonds',
      wrongDescription:
          'An index fund is a mutual fund, that allows an individual to “invest” in an index, such as the S&P 500. Index funds are very similar to how mutual funds work, but typically have very low fees and are the better choice'),
  Terms(
      name: 'Index Fund',
      rightDescription:
          'An index fund is a mutual fund, that allows an individual to “invest” in an index, such as the S&P 500. Index funds are very similar to how mutual funds work, but typically have very low fees and are the better choice',
      wrongDescription:
          'A mutual fund is a pooled portfolio. The fund itself holds the individual stocks, in the case of equity funds, or bonds, in the case of bond funds. Mutual funds are a great way to get exposure to groups of stocks or bonds, but be careful. Many have high fees that can eat away at your returns'),
  Terms(
      name: 'Bull Market',
      rightDescription:
          'A bull market when the market is moving in a positive direction and is expected to continue. Basically, optimism is high and investor confidence expects that strong results should continue, either for months or years',
      wrongDescription:
          'A bear market is a period where stock prices are falling. In a bear market, investor confidence is extremely low, and many investors start to sell off their stocks during a bear market for fear of further losses, thus fueling the negative market more'),
  Terms(
      name: 'Bear Market',
      rightDescription:
          'A bear market is a period where stock prices are falling. In a bear market, investor confidence is extremely low, and many investors start to sell off their stocks during a bear market for fear of further losses, thus fueling the negative market more',
      wrongDescription:
          'A Market when the market is moving in a positive direction and is expected to continue. Basically, optimism is high and investor confidence expects that strong results should continue, either for months or years')
];

VBoardParam telegaParam(String url) => VBoardParam(
      tg: url,
      image: 'assets/images/telega.png',
      function: () => MyNavigatorManager.instance.simulatorPop(),
      title: 'Join and earn',
      body: 'Join our Telegram group trade with our team',
      buttonText: 'Skip',
    );
