import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/friend/friend_list/logic.dart';
import 'package:girt_chat/pages/public/avatar.dart';

class ContractChildren extends StatelessWidget {
  final List<UserFriend> list;
  const ContractChildren({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FriendListLogic>();
    return Column(
      children: list
          .map(
            (e) => InkWell(
              onTap: () {
                logic.jumpToFriendInfoPage(e);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  children: [
                    AppAvatar(
                      name: ObjectUtil.stringIsNotBlank(e.friendRemark)
                          ? e.friendRemark!
                          : ObjectUtil.stringIsNotBlank(e.nickName)
                              ? e.nickName!
                              : e.username ?? "",
                      image: ObjectUtil.stringIsNotBlank(e.photoUrl) ? NetworkImage(e.photoUrl!) : null,
                      size: 50,
                    ),
                    Gap(getWidth(10)),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: .6)),
                        ),
                        child: Text(
                          ObjectUtil.stringIsNotBlank(e.friendRemark)
                              ? e.friendRemark!
                              : ObjectUtil.stringIsNotBlank(e.nickName)
                                  ? e.nickName!
                                  : e.username ?? "",
                          style: AppTexts.defaultStyles,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
