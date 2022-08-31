import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:soheel_app/constants.dart';
import 'package:soheel_app/core/location/location_manager.dart';
import 'package:soheel_app/core/location/search_model.dart';
import 'package:soheel_app/widgets/app/loading.dart';
import 'package:soheel_app/widgets/app_bar.dart';
import 'package:soheel_app/widgets/my_text.dart';
import 'package:soheel_app/widgets/text_form_field.dart';

class SearchLocationView extends StatefulWidget {
  const SearchLocationView({Key? key, required this.onSelect}) : super(key: key);

  final Function(LatLng) onSelect;

  @override
  State<SearchLocationView> createState() => _SearchLocationViewState();
}

class _SearchLocationViewState extends State<SearchLocationView> {

  String? searchKey;
  SearchModel? searchModel;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'بحث عن موقع'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InputFormField(
              hint: "بحث",
              onChanged: (v) => searchKey = v,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                ),
                onPressed: () async {
                  if (searchKey == null || searchKey!.trim().isEmpty) {
                    return;
                  }
                  closeKeyboard();
                  setState(() => isLoading = true);
                  searchModel = await LocationManager.getSearchResults(searchKey!);
                  print(searchModel?.candidates);
                  setState(() => isLoading = false);
                },
              ),
            ),
            Expanded(
              child: isLoading ? Center(child: Loading()) : ListView.builder(
                itemCount: searchModel?.candidates?.length ?? 0,
                itemBuilder: (context, index) => ListTile(
                  title: MyText(
                    title: searchModel?.candidates?[index].formattedAddress ?? '',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    final location = searchModel?.candidates?[index].geometry?.location;
                    widget.onSelect(LatLng(location!.lat!, location.lng!));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
