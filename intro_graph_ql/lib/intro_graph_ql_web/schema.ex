defmodule IntroGraphQlWeb.Schema do
  use Absinthe.Schema

  # query{
  #   getPostById(id: 1){
  #     id
  #     name
  #     description
  # 	}
  # }

  query do
    # Query Type
    # :get_post_by_id -> arg(:id) -> resolver(id) -> returns object :post
    field :get_post_by_id, :post do
      arg(:id, non_null(:id))
      # Resolver
      resolve fn _entity, %{id: id}, _context ->
        {:ok, IntroGraphQl.Blog.get_post!(id)}
      end
    end
  end

  # mutation{
  #   createPost(input: {name: "SecondPost", description: "description" }){
  #     id
  #     name
  #     description
  #   }
  # }

  mutation do
    field :create_post, :post do
      arg(:input, :post_input)
      resolve fn _entity, %{input: post_params}, _context ->
        IntroGraphQl.Blog.create_post(post_params)
      end
    end
  end

  # Object Type
  object :post do
    field :id, :id
    field :name, :string
    field :description, :string
  end

  input_object :post_input do
    field :name, :string
    field :description, :string
  end
end
