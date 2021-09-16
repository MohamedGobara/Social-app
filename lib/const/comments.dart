/*  if (const_isvervited == false)
                    Container(
                      width: double.infinity,
                      color: Color.fromRGBO(246, 209, 103, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            Container(
                              width: 220,
                              child: Text(
                                "Please verify your email",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black.withOpacity(0.2)),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text("Click here to confirm",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold))),
                            )
                          ],
                        ),
                      ),
                    ),*/


//------------------------------------
// FirebaseFirestore.instance
//     .collection("posts")
//     .doc(postid)
//     .get()
//     .then((value) async {
//   count_like = await value.data()["likes"];
// })
//    .then((value) {
//
//   FirebaseFirestore.instance
//       .collection("posts")
//       .doc(postid).update({"likes":count_like+1}).then((value) {
//         print(count_like.toString()) ;
//         print("like succefull")  ;
//         emit(successlike()) ;
//
//   }).catchError((error){print(error.toString());
//
//
//   emit(errorlike()) ;}) ;
//
//
//   });
