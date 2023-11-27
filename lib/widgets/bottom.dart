import 'package:binarium/bloc/home/home_bloc.dart';
import 'package:binarium/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.homeIndex != current.homeIndex,
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) => context
                .read<HomeBloc>()
                .add(ChangeHomeIndexEvent(homeIndex: value)),
            currentIndex: state.homeIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: bottomNavColor,
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/simmul_ico.png')),
                    Text('Calculator',
                        style: Theme.of(context).textTheme.bodySmall)
                  ],
                ),
                label: '',
                activeIcon: Column(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/simmul_icon.png')),
                    GradientText(
                      'Calculator',
                      colors: const [
                        // Color(0xFFFFFFFF),
                        Color(0xFF16CD8B),
                        Color(0xFF3C89CF),
                      ],
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/lesson_ico.png')),
                    Text('Lessons',
                        style: Theme.of(context).textTheme.bodySmall)
                  ],
                ),
                label: '',
                activeIcon: Column(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/lesson_icon.png')),
                    GradientText(
                      'Lessons',
                      colors: const [
                        // Color(0xFFFFFFFF),
                        Color(0xFF16CD8B),
                        Color(0xFF3C89CF),
                      ],
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/terms_ico.png')),
                    Text('Terms', style: Theme.of(context).textTheme.bodySmall)
                  ],
                ),
                label: '',
                activeIcon: Column(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/terms_icon.png')),
                    GradientText(
                      'Terms',
                      colors: const [
                        // Color(0xFFFFFFFF),
                        Color(0xFF16CD8B),
                        Color(0xFF3C89CF),
                      ],
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/comm_ico.png')),
                    Text('Community ',
                        style: Theme.of(context).textTheme.bodySmall)
                  ],
                ),
                label: '',
                activeIcon: Column(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/comm_icon.png')),
                    GradientText(
                      'Community',
                      colors: const [
                        // Color(0xFFFFFFFF),
                        Color(0xFF16CD8B),
                        Color(0xFF3C89CF),
                      ],
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('assets/images/profile_ico.png')),
                    Text('Profile',
                        style: Theme.of(context).textTheme.bodySmall)
                  ],
                ),
                label: '',
                activeIcon: Column(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/images/profile_icon.png'),
                    ),
                    GradientText(
                      'Profile',
                      colors: const [
                        // Color(0xFFFFFFFF),
                        Color(0xFF16CD8B),
                        Color(0xFF3C89CF),
                      ],
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
