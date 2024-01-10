part of 'widgets.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int myCurrentIndex = 0;
  List pages = const [
    HomePage(),
    SearchPage(),
    AddRecipePage(),
    ListMessagesPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(),
        child: BottomNavigationBar(
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.black.withOpacity(0.5),
          currentIndex: myCurrentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.facebookMessenger),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          onTap: (index) {
            setState(() {
              myCurrentIndex = index;
            });
          },
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}

class _ItemButtom extends StatelessWidget {
  final int i;
  final int index;
  final bool isIcon;
  final IconData? icon;
  final String? iconString;
  final Function() onPressed;
  final bool isReel;

  const _ItemButtom({
    Key? key,
    required this.i,
    required this.index,
    required this.onPressed,
    this.icon,
    this.iconString,
    this.isIcon = true,
    this.isReel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: (isIcon)
            ? Icon(icon,
                color: (i == index)
                    ? ColorsCustom.primary
                    : isReel
                        ? Colors.white
                        : Colors.black87,
                size: 28)
            : SvgPicture.asset(
                iconString!,
                height: 25,
              ),
      ),
    );
  }
}
