import 'dart:io';

import 'package:data_layer/blog/blog_api.dart';
import 'package:data_layer/blog/models/blog_model.dart';
import 'package:data_layer/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBlogApi implements BlogApi {
  final SupabaseClient supabaseClient;
  SupabaseBlogApi(this.supabaseClient);

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();

      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(
            blog.id,
            image,
          );

      return supabaseClient.storage.from('blog_images').getPublicUrl(
            blog.id,
          );
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
