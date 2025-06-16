<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Post;

class PostController extends Controller
{
    public function index()
    {
        logger('load posts');
        $posts = Post::with(['user', 'comments', 'likes'])
                    ->latest()
                    ->get()
                    ->map(function ($post) {
                        return [
                            'id' => $post->id,
                            'user_id' => $post->user_id,
                            'user_name' => $post->user->name,
                            'visibility' => $post->visibility,
                            'topic_name' => $post->topic_name,
                            'content' => $post->content,
                            'image_path' => $post->image_path ? asset('storage/' . $post->image_path) : null,
                            'created_at' => $post->created_at->toDateTimeString(),
                            'likes_count' => $post->likes->count(),
                            'comments_count' => $post->comments->count(),
                        ];
                    });
        logger("all post". $posts);

        return response()->json(['posts' => $posts]);
    }

    public function indexByUser(Request $request)
    {
        logger('load my posts');
        $user = $request->user(); // récupère l'utilisateur authentifié

        $posts = Post::with(['user', 'comments', 'likes'])
                    ->where('user_id', $user->id) // filtre les posts de l'utilisateur connecté
                    ->latest()
                    ->get()
                    ->map(function ($post) {
                        return [
                            'id' => $post->id,
                            'user_id' => $post->user_id,
                            'user_name' => $post->user->name,
                            'visibility' => $post->visibility,
                            'topic_name' => $post->topic_name,
                            'content' => $post->content,
                            'image_path' => $post->image_path ? asset('storage/' . $post->image_path) : null,
                            'created_at' => $post->created_at->toDateTimeString(),
                            'likes_count' => $post->likes->count(),
                            'comments_count' => $post->comments->count(),
                        ];
                    });

        return response()->json(['posts' => $posts]);
    }


    public function store(Request $request)
    {
        logger('stored post');

        $validated = $request->validate([
            'visibility' => 'required|in:Public,Private',
            'topic_name' => 'nullable|string|max:255',
            'content' => 'nullable|string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        logger($request->all());

        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('posts', 'public');
        }

        $post = Post::create([
            'user_id' => $request->user()->id,
            'visibility' => $validated['visibility'],
            'topic_name' => $validated['topic_name'] ?? null,
            'content' => $validated['content'] ?? null,
            'image_path' => $imagePath,
        ]);
        logger($post);

        return response()->json([
            'message' => 'Post created successfully',
            'data' => $post,
        ], 201);
    }

}
