import 'package:flutter/material.dart';
import 'package:ig_clone/widgets/forms/search_delegate.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showSearch(context: context, delegate: ChatSearchDelegate()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        height: 39,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffE5E5E5).withOpacity(0.75),
        ),
        child: Row(
          children: const [
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Buscar',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
