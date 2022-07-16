import 'package:chocobread/constants/sizes_helper.dart';
import 'package:chocobread/page/customformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class customForm extends StatefulWidget {
  customForm({Key? key}) : super(key: key);

  @override
  State<customForm> createState() => _FormState();
}

class _FormState extends State<customForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<
      FormState>(); // added to form widget to identify the state of form

  Widget SuggestionForm() {
    return SafeArea(
        child: Form(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                height: displayHeight(context),
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
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "제품명",
                        isDense: true, // textfield 내부의 padding 조절
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                      textInputAction: TextInputAction.next, // 완료 버튼 자리에 다음
                      keyboardType: TextInputType.text,
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return '제품명을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
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
                              TextFormField(
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
                                  prefixIconConstraints: const BoxConstraints(
                                      minWidth: 0, minHeight: 0),
                                  // suffixText: "원",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  // focus 가 사라졌을 때
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0.7, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // focus 가 맞춰졌을 때
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'[0-9]')), // 숫자만 입력 가능 only digits
                                  LengthLimitingTextInputFormatter(
                                      7), // 여섯자리 까지만 입력 가능 (백만원 단위까지 가능)
                                ],
                                validator: (String? val) {
                                  if (val == null || val.isEmpty) {
                                    return '배송비를 포함한 총가격을 입력해주세요.';
                                  }
                                  return null;
                                },
                              ),
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
                              TextFormField(
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
                                  prefixIconConstraints: const BoxConstraints(
                                      minWidth: 0, minHeight: 0),
                                  // suffixText: "명",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // focus 가 사라졌을 때
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0.7, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // focus 가 맞춰졌을 때
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // 숫자만 입력 가능 only digits
                                  LengthLimitingTextInputFormatter(
                                      2), // 두자리 까지만 입력 가능
                                ],
                                validator: (String? val) {
                                  if (val == null || val.isEmpty) {
                                    return '모집인원을 입력해주세요.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 거래 일시
                    const Text(
                      "거래 일시",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      // cursorColor: const Color(0xffF6BD60),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.calendar_month,
                        ),
                        hintText: "거래 일시",
                        isDense: true,
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // 숫자만 입력 가능 only digits
                        LengthLimitingTextInputFormatter(2), // 두자리 까지만 입력 가능
                      ],
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return '거래 일시를 입력해주세요.';
                        }
                        return null;
                      },
                    ),
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
                    TextFormField(
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
                            borderSide: const BorderSide(
                                width: 0.7, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // focus 가 맞춰졌을 때
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 내용
                    const Text(
                      "추가 작성 (선택)",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "추가적으로 덧붙이고 싶은 내용이 있다면 알려주세요.",
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
                      keyboardType: TextInputType.text,
                    ),
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              const SnackBar(
                                content: Text("제안 완료"),
                              );
                            }
                          },
                          child: const Text('제안하기'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SuggestionForm();
  }
}