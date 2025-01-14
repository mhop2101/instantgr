import 'package:instantgramclonexyz/state/constants/firebase_collection_name.dart';
import 'package:instantgramclonexyz/state/image_upload/models/file_type.dart';

extension CollectionName on FileType {
  String get collectionName {
    switch (this) {
      case FileType.image:
        return FirebaseCollectionName.images;
      case FileType.video:
        return FirebaseCollectionName.videos;
    }
  }
}
