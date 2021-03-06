import 'dart:ffi';

import 'package:chocobread/constants/sizes_helper.dart';
import 'package:chocobread/page/customformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../utils/price_utils.dart';
import 'app.dart';

class customFormChange extends StatefulWidget {
  Map<String, dynamic> data;
  customFormChange({Key? key, required this.data}) : super(key: key);

  @override
  State<customFormChange> createState() => _customFormChangeState();
}

class _customFormChangeState extends State<customFormChange> {
  final now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productNameController.text = widget.data["title"];
    productLinkController.text = widget.data["link"];
    totalPriceController.text =
        PriceUtils.calcStringToWonOnly(widget.data["totalPrice"]);
    numOfParticipantsController.text = widget.data["totalMember"];
    dateController.text =
        widget.data["date"].substring(0, 12); // 서버에서 보내는 형식을 보고 수정할 것!
    timeController.text = widget.data["date"].substring(
      14,
    );
    placeController.text = widget.data["place"];
    extraController.text = widget.data["contents"];
  }

  // 각각의 textfield에 붙는 controller
  TextEditingController productNameController =
      TextEditingController(); // 제품명에 붙는 controller
  TextEditingController productLinkController =
      TextEditingController(); // 판매 링크에 붙는 controller
  TextEditingController totalPriceController =
      TextEditingController(); // 총 가격에 붙는 controller
  TextEditingController numOfParticipantsController =
      TextEditingController(); // 모집 인원에 붙는 controller
  TextEditingController dateController =
      TextEditingController(); // 거래 날짜에 붙는 controller
  TextEditingController timeController =
      TextEditingController(); // 거래 시간에 붙는 controller
  TextEditingController placeController =
      TextEditingController(); // 거래 장소에 붙는 controller
  TextEditingController extraController =
      TextEditingController(); // 추가 작성에 붙는 controller

  // 서버에 보내기 위해 제안하기 버튼을 눌렀을 때 데이터 저장하기
  String productName = ""; // 제품명
  String productLink = ""; // 판매 링크
  String totalPrice = ""; // 총 가격
  String numOfParticipants = ""; // 모집 인원
  String date = ""; // 거래 날짜
  String time = ""; // 거래 시간
  String place = ""; // 거래 장소
  String extra = ""; // 추가 작성

  final GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); // added to form widget to identify the state of form

  Widget _productNameTextFormField() {
    return TextFormField(
      controller: productNameController,
      decoration: InputDecoration(
        hintText: "제품명",
        isDense: true, // textfield 내부의 padding 조절
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        // focus 가 사라졌을 때
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.7, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 맞춰졌을 때
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textInputAction: TextInputAction.next, // 완료 버튼 자리에 다음
      keyboardType: TextInputType.text,
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '제품명을 입력해주세요.';
        }
        return null;
      },
    );
  }

  Widget _productLinkTextFormField() {
    return TextFormField(
      controller: productLinkController,
      // cursorColor: const Color(0xffF6BD60),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.link_rounded,
        ),
        hintText: "판매 링크",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 사라졌을 때
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.7, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 맞춰졌을 때
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
    );
  }

  Widget _totalPriceTextFormField() {
    return TextFormField(
      controller: totalPriceController
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: totalPriceController.text
                .length)), // 총가격에 controller를 붙여서 , 처리를 하면 커서가 앞으로 이동하는데, 이를 막고 커서가 항상 뒤에 있도록 조정
      decoration: InputDecoration(
        // hintText: "총가격(배송비 포함)",
        isDense: true,
        suffixIcon: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "원",
            style: TextStyle(fontSize: 16),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        // suffixText: "원",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        // focus 가 사라졌을 때
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.7, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 맞춰졌을 때
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]')), // 숫자만 입력 가능 only digits
        LengthLimitingTextInputFormatter(7), // 여섯자리 까지만 입력 가능 (백만원 단위까지 가능)
      ],
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '총가격을 입력해주세요.';
        }
        return null;
      },
      onChanged: (String totalprice) {
        // print(totalprice);
        setState(() {
          totalPrice = totalprice;
          totalPriceController.text =
              PriceUtils.calcStringToWonOnly(totalprice);
        });
      },
    );
  }

  Widget _participantsTextFormField() {
    return TextFormField(
      controller: numOfParticipantsController,
      decoration: InputDecoration(
        // hintText: "모집 인원(나 포함)",
        isDense: true,
        suffixIcon: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "명",
            style: TextStyle(fontSize: 16),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        // suffixText: "명",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 사라졌을 때
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.7, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 맞춰졌을 때
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능 only digits
        LengthLimitingTextInputFormatter(2), // 두자리 까지만 입력 가능
      ],
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '모집인원을 입력해주세요.';
        }
        return null;
      },
      onChanged: (String numofparticipants) {
        // print(numofparticipants);
        setState(() {
          numOfParticipants = numofparticipants;
        });
      },
    );
  }

  Widget _pricePerPerson(String totalprice, String numofparticipants) {
    if (totalprice.isNotEmpty & numofparticipants.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Text(
          "1인당 부담 가격: ${PriceUtils.calcStringToWonOnly(((int.parse(totalprice) / int.parse(numofparticipants) / 10).ceil() * 10).toString())} 원",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
    return const Padding(
      padding: EdgeInsets.only(left: 3),
      child: Text(
        "1인당 부담 가격: ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _dateTextFormField() {
    return TextFormField(
      controller: dateController,
      readOnly: true, // make user not able to edit text
      // cursorColor: const Color(0xffF6BD60),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.calendar_month,
        ),
        hintText: "거래 날짜",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 사라졌을 때
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.7, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 맞춰졌을 때
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능 only digits
        LengthLimitingTextInputFormatter(6), // 두자리 까지만 입력 가능
      ],
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '거래 날짜를 입력해주세요.';
        }
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day + 4),
            firstDate: DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day + 4),
            lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1,
                DateTime.now().day + 4));
        if (pickedDate != null) {
          String formattedDate = DateFormat('yy.MM.dd.').format(pickedDate);
          String? weekday = {
            "Mon": "월",
            "Tue": "화",
            "Wed": "수",
            "Thu": "목",
            "Fri": "금",
            "Sat": "토",
            "Sun": "일"
          }[DateFormat("E").format(pickedDate)];
          setState(() {
            dateController.text = "$formattedDate$weekday";
          });
        }
      },
    );
  }

  Widget _timeTextFormField() {
    return TextFormField(
      controller: timeController,
      readOnly: true, // make user not able to edit text
      // cursorColor: const Color(0xffF6BD60),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.access_time_filled_rounded,
        ),
        hintText: "거래 시간",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 사라졌을 때
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.7, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 맞춰졌을 때
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능 only digits
        LengthLimitingTextInputFormatter(4), // 두자리 까지만 입력 가능
      ],
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '거래 시간을 입력해주세요.';
        }
        return null;
      },
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());

        if (pickedTime != null) {
          DateTime parsedTime = DateFormat.jm('ko_KR').parse(pickedTime
              .format(context)
              .toString()); // converting to DateTime so that we can format on different pattern (ex. jm : 5:08 PM)
          String formattedTime = DateFormat("h:mm").format(parsedTime);
          String? dayNight = {
            "AM": "오전",
            "PM": "오후"
          }[DateFormat("a").format(parsedTime)]; // AM, PM을 한글 오전, 오후로 변환

          setState(() {
            timeController.text = "${dayNight!} $formattedTime";
          });
        }
      },
    );
  }

  Widget _placeTextFormField() {
    return TextFormField(
      controller: placeController,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.place),
          hintText: "거래 장소 (ex. 5동 관리 사무소 앞)",
          // hintStyle: const TextStyle(height: 1.3), // 아이콘과 높이 맞추기 위한 것
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // focus 가 사라졌을 때
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.7, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          // focus 가 맞춰졌을 때
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          )),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '거래 장소를 입력해주세요.';
        }
        return null;
      },
    );
  }

  Widget _extraTextFormField() {
    return TextFormField(
      controller: extraController,
      maxLines: null,
      decoration: InputDecoration(
        hintText: "추가적으로 덧붙이고 싶은 내용이 있다면 알려주세요.",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 사라졌을 때
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.7, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        // focus 가 맞춰졌을 때
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget SuggestionFormChange() {
    return SafeArea(
        child: Form(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제품명
                    const Text(
                      "제품명",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _productNameTextFormField(),
                    const SizedBox(
                      height: 30,
                    ),
                    // 판매 링크
                    const Text(
                      "판매 링크 (선택)",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _productLinkTextFormField(),
                    const SizedBox(
                      height: 30,
                    ),
                    // 단위 가격
                    const Text(
                      "단위 가격",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // 총가격 (배송비 포함)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Text(
                                  "총가격 (배송비 포함)",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              _totalPriceTextFormField(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        // 모집 인원 (나 포함)
                        Expanded(
                          // textfield cannot have unbounded height
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Text(
                                  "모집 인원 (나 포함)",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              _participantsTextFormField()
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // 1인당 부담해야 할 가격
                    _pricePerPerson(totalPrice, numOfParticipants),
                    const SizedBox(
                      height: 30,
                    ),
                    // 거래 날짜
                    const Text(
                      "거래 날짜",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _dateTextFormField(),
                    const SizedBox(
                      height: 30,
                    ),
                    // 거래 시간
                    const Text(
                      "거래 시간",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _timeTextFormField(),
                    const SizedBox(
                      height: 30,
                    ),
                    // 거래 장소
                    const Text(
                      "거래 장소",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _placeTextFormField(),
                    const SizedBox(
                      height: 30,
                    ),
                    // 내용
                    const Text(
                      "내용 (선택)",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _extraTextFormField(),
                    const SizedBox(
                      height: 15,
                    ),
                    //제안하기 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          // onPressed: () {
                          //   // Validate returns true if the form is valid, or false otherwise.
                          //   if (_formKey.currentState!.validate()) {
                          //     // If the form is valid, display a snackbar. In the real world,
                          //     // you'd often call a server or save the information in a database.
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text('성공적으로 제안되었습니다!')),
                          //     );
                          //   }
                          // },
                          onPressed: () {
                            setState(() {
                              productName = productNameController.text; // 제품명
                              productLink = productLinkController.text; // 판매 링크
                              date = dateController.text; // 거래 날짜
                              time = timeController.text; // 거래 시간
                              place = placeController.text; // 거래 장소
                              extra = extraController.text; // 추가 작성
                            });

                            const snackBar = SnackBar(
                              content: Text(
                                "성공적으로 제안되었습니다!",
                                style: TextStyle(color: Colors.white),
                              ),
                              // backgroundColor: Colors.black,
                              duration: Duration(milliseconds: 2000),
                              // behavior: SnackBarBehavior.floating,
                              elevation: 50,
                              shape: StadiumBorder(),
                              // RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.only(
                              //         topLeft: Radius.circular(30),
                              //         topRight: Radius.circular(30))),
                            );

                            // form 이 모두 유효하면, 홈으로 이동하고, 성공적으로 제출되었음을 알려준다.
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const App();
                              }));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: const Text('제안하기'),
                        ),
                        // 서버로 보낼 데이터가 제대로 저장되었는지 확인하기 위한 것
                        // Flexible(
                        //   child: Text(
                        //       "${productName} ${productLink} ${date} ${time} ${place} ${extra}"),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SuggestionFormChange();
  }
}
