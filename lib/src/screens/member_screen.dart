import 'package:attendant151/src/common_widgets/empty_content.dart';
import 'package:attendant151/src/models/member.dart';
import 'package:attendant151/src/routes/app_route.dart';
import 'package:attendant151/src/services/member_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MemberScreen extends ConsumerWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(AppRoute.addmember.name),
            icon: const Icon(Icons.add),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final memberQueryStream = ref.watch(memberStreamProvider);
          return memberQueryStream.when(
              data: (items) => ListView.separated(
                  itemCount: items.length + 2,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0.5),
                  itemBuilder: (context, index) {
                    if (index == 0 || index == items.length + 1) {
                      return const SizedBox.shrink();
                    }
                    return MemberListTile(member: items[index - 1]);
                  }),
              error: (_, __) => const EmptyContent(
                    title: 'Something went wrong',
                    message: 'Can\'t load items right now',
                  ),
              loading: () => const Center(child: CircularProgressIndicator()));
          // return ListItemsBuilder<Member>(
          //     data: memberQueryStream,
          //     itemBuilder: (context, member) => MemberListTile(member: member));
        },
      ),
    );
  }
}

class MemberListTile extends StatelessWidget {
  const MemberListTile({Key? key, required this.member}) : super(key: key);
  final Member member;

  @override
  Widget build(BuildContext context) {
    return SlideMenu(
        menuItems: <Widget>[
          Container(
            color: Colors.black12,
            child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    context.goNamed(AppRoute.editmember.name, extra: member)),
          ),
          Container(
            color: Colors.red,
            child: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.delete),
              onPressed: () => showAlertDialog(context),
            ),
          )
        ],
        child: ListTile(
          title: Text(
            '${member.firstname} ${member.lastname}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(children: [
            const Text('RFID:'),
            const Spacer(),
            Text(member.rfid)
          ]),
          onTap: () =>
              context.goNamed(AppRoute.memberdetail.name, extra: member),
        ));
  }
}

class SlideMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;

  const SlideMenu({Key? key, required this.child, required this.menuItems})
      : super(key: key);

  @override
  State<SlideMenu> createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Here the end field will determine the size of buttons which will appear after sliding
    //If you need to appear them at the beginning, you need to change to "+" Offset coordinates (0.2, 0.0)
    final animation =
        Tween(begin: const Offset(0.0, 0.0), end: const Offset(-0.2, 0.0))
            .animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    return GestureDetector(onHorizontalDragUpdate: (data) {
      // we can access context.size here
      setState(() {
        //Here we set value of Animation controller depending on our finger move in horizontal axis
        //If you want to slide to the right, change "-" to "+"
        _controller.value -= (data.primaryDelta! / (context.size!.width * 0.2));
      });
    }, onHorizontalDragEnd: (data) {
      //To change slide direction, change to data.primaryVelocity! < -1500
      if (data.primaryVelocity! > 1500) {
        _controller
            .animateTo(.0); //close menu on fast swipe in the right direction
      } else if (_controller.value >= .5 || data.primaryVelocity! < -1500) {
        _controller.animateTo(1.0);
      } // fully open if dragged a lot to left or on fast swipe to left
      else {
        // close if none of above
        _controller.animateTo(.0);
      }
    }, child: LayoutBuilder(builder: (context, constraint) {
      return Stack(
        children: [
          SlideTransition(
            position: animation,
            child: widget.child,
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                //To change slide direction to right, replace the right parameter with left:
                return Positioned(
                  right: .0,
                  top: .0,
                  bottom: .0,
                  width: constraint.maxWidth * animation.value.dx * -1,
                  child: Row(
                    children: widget.menuItems.map((child) {
                      return Expanded(
                        child: child,
                      );
                    }).toList(),
                  ),
                );
              })
        ],
      );
    }));
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: const Text("OK"),
    onPressed: () {},
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Delete Member"),
    content: const Text("Are you sure that you want to delete?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
