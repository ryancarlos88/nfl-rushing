defmodule NflRushing.Utils.Pagination do
  import Ecto.Query
  alias NflRushing.Repo

  @spec query(Ecto.Query.t(), number, number) :: any
  def query(query, page_number, page_size) do
    query
    |> limit(^(page_size + 1))
    |> offset(^(page_size * (page_number - 1)))
    |> Repo.all()
  end

  @spec page(Ecto.Query.t(), binary | number, binary | non_neg_integer) :: %{
          count: number,
          current_page: number,
          first: number,
          first_page: 1,
          has_next: boolean,
          has_prev: boolean,
          items: list,
          last: any,
          last_page: integer,
          next_page: number,
          prev_page: number
        }
  def page(query, page_number, page_size) when is_binary(page_number),
    do: page(query, String.to_integer(page_number), page_size)

  def page(query, page_number, page_size) when is_binary(page_size),
    do: page(query, page_number, String.to_integer(page_size))

  def page(query, page_number, page_size) when is_binary(page_number) and is_binary(page_size),
    do: page(query, String.to_integer(page_number), String.to_integer(page_size))

  def page(query, page_number, page_size) do
    results = query(query, page_number, page_size)
    has_next = length(results) > page_size
    has_prev = page_number > 1
    count = Repo.one(from(r in subquery(query), select: count("*")))

    %{
      has_next: has_next,
      has_prev: has_prev,
      prev_page: page_number - 1,
      next_page: page_number + 1,
      current_page: page_number,
      first: (page_number - 1) * page_size + 1,
      last: Enum.min([page_number * page_size, count]),
      count: count,
      items: Enum.slice(results, 0, page_size),
      first_page: 1,
      last_page: Kernel.ceil(count/page_size)
    }
  end

end
