defmodule EmployeeRewardApp.BootstrapHelpers do

  defmacro __using__(_opts) do
    quote do
      import Phoenix.HTML
      import Phoenix.HTML.Form, except: [text_input: 2, text_input: 3, file_input: 3, email_input: 3, password_input: 2, password_input: 3, textarea: 3, telephone_input: 3, number_input: 3, number_input: 2, date_input: 3, date_select: 3, datetime_select: 3, select: 3, select: 4, time_select: 3, time_input: 3, url_input: 3, multiple_select: 4, range_input: 3]
      import Phoenix.HTML.Link
      import Phoenix.HTML.Tag
      import Phoenix.HTML.Format
      import EmployeeRewardApp.BootstrapHelpers
    end
  end

  [:text_input, :file_input, :email_input, :password_input, :textarea, :telephone_input, :number_input, :date_input, :date_select, :datetime_select, :time_select, :time_input, :url_input, :range_input]
  |> Enum.each(fn method ->
    def unquote(method)(form, field, opts \\ []) when is_atom(field) do
      opts = add_is_invalid_to_invalid_input(form, field, opts)
      elem(Code.eval_string("Phoenix.HTML.Form.#{Atom.to_string(elem(__ENV__.function, 0))}(form, field, opts)", [form: form, field: field, opts: opts]), 0)
    end
  end)

  [:select, :multiple_select]
  |> Enum.each(fn method ->
    def unquote(method)(form, field, options, opts \\ []) when is_atom(field) do
      opts = add_is_invalid_to_invalid_input(form, field, opts)
      elem(Code.eval_string("Phoenix.HTML.Form.#{Atom.to_string(elem(__ENV__.function, 0))}(form, field, options, opts)", [form: form, field: field, options: options, opts: opts]), 0)
    end
  end)

  defp add_is_invalid_to_invalid_input(form, field, opts) do
    if !is_atom(form) && Keyword.has_key?(form.errors, field), do: Keyword.update(opts, :class, "is-invalid", &("#{&1} is-invalid")), else: opts
  end

end
