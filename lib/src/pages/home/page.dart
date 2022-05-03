import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/global.dart';
import '../../router/router.dart';
import '../../tools/launcher/launcher.dart';
import 'model.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    this.footer,
  }) : super(key: key);

  final List<String>? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: bodyView(context),
      bottomSheet: footerView(),
      drawer: drawerView(context),
    );
  }

  Widget? drawerView(BuildContext context) {
    if (!context.isPhone) return null;

    return Drawer(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(32),
        children: AppRouter.docx
            .map((m) => ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: Text(m.name),
                  onTap: m.hash == null
                      ? null
                      : () => Get.toNamed(AppRouter.view + '/' + m.hash!),
                ))
            .toList(),
      ),
    );
  }

  Widget bodyView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 32),
        Center(
          child: Text(
            Global.declare,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        const SizedBox(height: 20),
        context.isPhone ? bodyPortPhone() : bodyPortDesktop(),
      ],
    );
  }

  Widget bodyPortPhone() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppRouter.cenx.length,
      itemBuilder: (context, index) {
        final model = AppRouter.cenx[index];
        return ListTile(
          leading: Image.network(
            model.image,
            width: 72,
            height: 60,
            fit: BoxFit.cover,
          ),
          title: Text(
            model.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            model.content ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }

  Widget bodyPortDesktop() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 72),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 48,
        mainAxisSpacing: 32,
      ),
      itemCount: AppRouter.cenx.length,
      itemBuilder: (context, index) {
        final model = AppRouter.cenx[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      model.image,
                      width: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              model.content ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }

  Widget? footerView() {
    if (footer == null) return null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: Colors.black87,
      child: Wrap(
        children: footer!
            .map((e) => Text(
                  e,
                  style: const TextStyle(color: Colors.white),
                ))
            .toList(),
        spacing: 8,
        runSpacing: 4,
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: context.isPhone
          ? Builder(
              builder: (ctx) {
                return IconButton(
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                  icon: const Icon(CupertinoIcons.square_list),
                );
              },
            )
          : IconButton(
              onPressed: () => Get.offAllNamed(AppRouter.home),
              icon: const Icon(Icons.flutter_dash_rounded),
            ),
      title: const Text('思思的博客'),
      centerTitle: false,
      actions: context.isPhone
          ? null
          : [
              ...AppRouter.docx.map((m) {
                return _PopupBottonView(model: m);
              }).toList(),
              const SizedBox(width: 32),
            ],
    );
  }
}

class _PopupBottonView extends StatelessWidget {
  _PopupBottonView({
    Key? key,
    required this.model,
  }) : super(key: key);

  final TopNavItemModel model;
  final anchorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MouseRegion(
          onHover: (_) async {
            if (model.children == null) return;
            final renderBox = context.findRenderObject() as RenderBox;

            final hash = await showMenu<String>(
              context: context,
              position: RelativeRect.fromLTRB(
                renderBox.localToGlobal(Offset.zero).dx,
                renderBox.size.height,
                0,
                0,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
              ),
              items: model.children!
                  .map((m) => PopupMenuItem<String>(
                        onTap: () => Get.back(result: m.hash),
                        child: Text(m.name),
                      ))
                  .toList(),
            );
            if (hash != null) {
              launchUrl(AppRouter.view + '/' + hash);
            }
          },
          child: ElevatedButton(
            key: anchorKey,
            child: Text(model.name),
            onPressed: model.hash == null
                ? null
                : () => Get.toNamed(AppRouter.view + '/' + model.hash!),
            style: Theme.of(context).textButtonTheme.style,
          ),
        );
      }
    );
  }
}
