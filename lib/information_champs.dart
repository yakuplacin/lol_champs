import "package:flutter/material.dart";

class InformationChamps extends StatefulWidget {
  var response;
  var champ;
  var img;

  InformationChamps(this.response, this.champ, this.img);

  @override
  State<InformationChamps> createState() => _InformationChampsState();
}

class _InformationChampsState extends State<InformationChamps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black87,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  (widget.img.toString().substring(0,  widget.img.toString().length-5) + "1.jpg").toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.response["data"][widget.champ]["name"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          widget.response["data"][widget.champ]["title"],
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Overview",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Text(
              widget.response["data"][widget.champ]["blurb"],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
