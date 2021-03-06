import 'package:flutter/material.dart';

import '../constants/sizes_helper.dart';

class DetailCommentsView extends StatefulWidget {
  List<Map<String, dynamic>> data;
  DetailCommentsView({Key? key, required this.data, required this.replyTo})
      : super(key: key);
  String replyTo;

  @override
  State<DetailCommentsView> createState() => _DetailCommentsViewState();
}

class _DetailCommentsViewState extends State<DetailCommentsView> {
  final globalKeysOut = <GlobalKey>[];
  // int heightcontroller = 55;
  String replyToHere = "";

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: const Text("댓글"),
      centerTitle: false,
      titleSpacing: 0,
      elevation: 0,
      bottomOpacity: 0,
      backgroundColor: Colors.transparent,
    );
  }

  Color _colorUserStatus(String userstatus) {
    switch (userstatus) {
      case "제안자":
        return Colors.red; // 제안자의 색
      case "참여자":
        return Colors.blue; // 참여자의 색
    }
    return Colors.grey; // 지나가는 사람의 색
  }

  Widget _userStatusChip(String userstatus) {
    if (userstatus == "") {
      return Container();
    } else {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _colorUserStatus(userstatus),
          ),
          // const Color.fromARGB(255, 137, 82, 205)),
          child: Text(
            userstatus,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
          ));
    }
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: ListView.separated(
          physics:
              const NeverScrollableScrollPhysics(), // listview 가 scroll 되지 않도록 함
          padding: const EdgeInsets.symmetric(horizontal: 15),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int firstIndex) {
            globalKeysOut.add(GlobalKey());
            return Container(
                key: globalKeysOut[widget.data[firstIndex]["id"]],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: _colorUserStatus(
                              widget.data[firstIndex]["userStatus"]),
                          // size: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${widget.data[firstIndex]["userNickname"]}",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        _userStatusChip(
                            widget.data[firstIndex]["userStatus"].toString()),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${widget.data[firstIndex]["fromThen"]}",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // 댓글 내용
                    Padding(
                      padding: const EdgeInsets.only(left: 29.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "${widget.data[firstIndex]["content"]}",
                              // softWrap: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 19.0),
                      child: TextButton(
                          onPressed: () {
                            // final targetcomments = testkey.currentContext;
                            // if (targetcomments != null) {
                            //   Scrollable.ensureVisible(targetcomments);
                            // }

                            // 답글쓰기 버튼을 눌렀을 때 enablecommentsbox 가 true로 변하면서 댓글 입력창이 나타난다.
                            // setState(() {
                            //   enablecommentsbox = true;
                            // });
                            // currentfocusnode.requestFocus(); // 답글쓰기 버튼을 누르면,

                            // 답글쓰기 버튼을 누르면, 댓글 페이지로 넘어가기
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (BuildContext context) {
                            //   return DetailCommentsView(
                            //     data: widget.data,
                            //   );
                            // }));

                            // 답글쓰기 버튼을 눌렀을 때
                            final targetcomments =
                                globalKeysOut[widget.data[firstIndex]["id"]]
                                    .currentContext;
                            if (targetcomments != null) {
                              Scrollable.ensureVisible(targetcomments,
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOut);
                              setState(() {
                                replyToHere =
                                    "${widget.data[firstIndex]["userNickname"]}";
                              });
                            }
                          },
                          child: const Text("답글쓰기",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ))),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25),
                      width: displayWidth(context) - 80,
                      height: 1,
                      color: const Color(0xffF0EBE0),
                    ),
                    // 대댓글
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int secondIndex) {
                          return Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: _colorUserStatus(
                                          widget.data[firstIndex]["Replies"]
                                              [secondIndex]["userStatus"]),
                                      // size: 30,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${widget.data[firstIndex]["Replies"][secondIndex]["userNickname"]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    _userStatusChip(widget.data[firstIndex]
                                            ["Replies"][secondIndex]
                                            ["userStatus"]
                                        .toString()),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${widget.data[firstIndex]["Replies"][secondIndex]["fromThen"]}",
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // 댓글 내용
                                Padding(
                                  padding: const EdgeInsets.only(left: 29.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${widget.data[firstIndex]["Replies"][secondIndex]["content"]}",
                                          // softWrap: true,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 19.0),
                                //   child: TextButton(
                                //       // focusNode: currentfocusnode,
                                //       onPressed: () {
                                //         // 답글쓰기를 누르면 해당 글에
                                //         // final targetcomments =
                                //         //     globalKeysOut[counter]
                                //         //         .currentContext;
                                //         // if (targetcomments != null) {
                                //         //   Scrollable.ensureVisible(
                                //         //       targetcomments,
                                //         //       duration: const Duration(
                                //         //           milliseconds: 600),
                                //         //       curve: Curves.easeInOut);
                                //         // }
                                //       },
                                //       child: const Text("답글쓰기",
                                //           style: TextStyle(
                                //             color: Colors.grey,
                                //             fontSize: 12,
                                //           ))),
                                // ),
                              ]));
                        },
                        separatorBuilder:
                            (BuildContext context, int firstIndex) {
                          return Container(
                            height: 1,
                            color: const Color(0xffF0EBE0),
                            // const Color(0xfff0f0ef),
                          );
                        },
                        itemCount: widget.data[firstIndex]["Replies"].length)
                  ],
                ));
          },
          separatorBuilder: (BuildContext context, int firstIndex) {
            return Container(
              height: 1,
              color: const Color(0xffF0EBE0),
              // const Color(0xfff0f0ef),
            );
          },
          itemCount: widget.data.length),
    );
  }

  Widget _replyToText() {
    if (replyToHere != "") {
      return Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    replyToHere = "";
                  });
                },
                icon: Icon(Icons.clear_rounded),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                iconSize: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text("${replyToHere} 님 댓글에 답글하기"),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      );
    } else if ("${widget.replyTo}" != "") {
      return Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.replyTo = "";
                  });
                },
                icon: Icon(Icons.clear_rounded),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                iconSize: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text("${widget.replyTo} 님 댓글에 답글하기"),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      );
    }
    return Container();
  }

  double heightcontroller() {
    if ("${widget.replyTo}" != "" || replyToHere != "") {
      return 95;
    }
    return 69;
  }

  Widget _bottomTextfield() {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, // 키보드 위로 댓글 입력창이 올라오도록 처리
      child: Material(
        elevation: 55,
        child: Container(
          height: heightcontroller(),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _replyToText(),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      // focusNode: currentfocusnode,
                      // initialValue: "${widget.replyTo}",
                      autofocus:
                          true, // 답글쓰기나 댓글 입력 textfield 를 누르면, comments page 로 이동해서 textfield에 자동 focus 이동
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "댓글을 입력해주세요.",
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10, top: 7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // focus 가 사라졌을 때
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 0.7, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // focus 가 맞춰졌을 때
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // 댓글을 입력하면 이전 디테일 페이지로 이동한다.
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.send_rounded),
                    padding: const EdgeInsets.only(
                        left: 10, right: 0, top: 0, bottom: 0),
                    constraints: const BoxConstraints(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus
            ?.unfocus(); // textfield 이외의 곳을 탭하면, 키보드가 아래로 내려간다.
      },
      child: Scaffold(
        appBar: _appbarWidget(),
        body: _bodyWidget(),
        bottomNavigationBar: _bottomTextfield(),
      ),
    );
  }
}
