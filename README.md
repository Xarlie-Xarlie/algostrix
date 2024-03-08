# Algostrix

Algostrix is an app that contains implementations of the most common data structures and algorithms based on the [Master the Coding Interview: Data Structures + Algorithms](https://www.udemy.com/course/master-the-coding-interview-data-structures-algorithms/) course.

I have endeavored to implement every data structure, algorithm, and exercises using Elixir.

You can find the algorithms at:
```
lib
├─ algostrix
│ ├─ data_structures
│ │ ├─ linked_lists
│ │ │ ├─ double_linked_list.ex
│ │ │ ├─ double_linked_list_node.ex
│ │ │ ├─ linked_list.ex
│ │ │ └─ linked_list_node.ex
│ │ ├─ queues
│ │ │ ├─ queue_linked_list_node.ex
│ │ │ ├─ queue_with_linked_lists.ex
│ │ │ └─ queue_with_lists.ex
│ │ ├─ stacks
│ │ │ ├─ stack_linked_list_node.ex
│ │ │ ├─ stack_with_linked_lists.ex
│ │ │ └─ stacks_with_lists.ex
│ │ ├─ trees
│ │ │ ├─ binary_search_tree.ex
│ │ │ ├─ binary_tree_node.ex
│ │ └─ array.ex
│ ├─ extras
│ │ ├─ first_recurring_character.ex
│ │ └─ merge_sorted_lists.ex
```
---

Feel free to use this project to test your implementations and gain insights into how you can implement various data structures using Elixir's functional approach.

---

# Big O

- A tool to analyze efficiency of code. It describes the behaviour of a function as it’s arguments converger to a specific value or to infinity.
- You can use Big O to measure how many steps it will take to complete an operation, function or block of code.
- Also, you can use it to measure the amount of memory it will cost to OS.

### Types

Here is the list of the types that you could find in Big O notation:

1. `O(1)` Constant - no loops
2. `O(log n)` Logarithmic - usually searching algorithms have log n if they are sorted (Binary Search)
3. `O(n)` Linear - for loops, while loops through n items
4. `O(n log(n))` Log Linear - usually sorting operations
5. `O(n^2)` Quadratic - every element in a collection needs to be compared to ever other element. Two nested loops
6. `O(2^n)` Exponential - recursive algorithms that solves a problem of size N
7. `O(n!)` Factorial - you are adding a loop for every element

## What is a good code?

Good code can be described by the following specifications:

1. Readable:
    
    A code that can be realiable, maintanable and easy to understand.
    Try using variables that describe what values they are storing, and make it more legible.
    
    ```elixir
    def mean(list) do
      Enum.reduce(list, 0, fn x, acc -> x + acc end)
      |> Kernel./(length(list))
    end
    ```
    
    ```elixir
    def calculate_mean(elements) do
      sum_of_elements = 
    		Enum.reduce(elements, 0, fn element, acumulator -> element + acumulator end)
    	
    	qty_of_elements = length(elements)
      
    	sum_of_elements / qty_of_elements
    end
    ```
    
    Even if you’re familiar with Elixir, the second function is more readable than the first one.
    
    You can enhance your code by adding documentation and examples:
    
    ```elixir
    @doc """
    Calculate the mean of elements.
    
    Only accept numbers, otherwise it will raise ArithmeticError.
    
    ## Parameters:
      - `elements`: a list of numbers to calculate the mean.
    
    ## Examples:
    	iex> calculate_mean([1, 2, 3])
      2.0
      
      iex> calculate_mean([1, 1, 1, 1])
      1.0
    """
    @spec calculate_mean(elements :: [number()]) :: number()
    def calculate_mean(elements) do
      sum_of_elements = sum_elements(elements)
    	qty_of_elements = length(elements)
      
    	sum_of_elements / qty_of_elements
    end
    
    @spec sum_elements(elements :: [number()]) :: number()
    defp sum_elements(elements) do
      Enum.reduce(elements, 0, fn element, acumulator -> element + acumulator end)
    end
    ```
    
2. Time Complexity:
    
    How long it will take to run a code.
    
    - $O(1)$
        
        ```elixir
        def return_first_element(elements) do
          List.first(elements) # O(1)
        end
        
        def return_first_element([first | _rest]) do: first # O(1)
        ```
        
        Both of the above functions return the first element of an list of elements. That means, not matter how many elements you have in your list, it will take exactly a single operation to take the first element.
        
        $O(log(n))$
        
        ```elixir
        @spec lookup(tree :: t(), value :: any()) :: nil | BTN.t()
        def lookup(%Tree{root: nil}, _value), do: nil
        
        def lookup(%tree{root: root}, value) do
          do_lookup(root, value)
        end
        
        @spec do_lookup(tree_node :: BTN.t(), value :: any()) :: nil | BTN.t()
        defp do_lookup(%BTN{value: value} = node, value), do: node
        defp do_lookup(%BTN{value: current_value, left: nil}, value) when current_value > value, do: nil
        
        defp do_lookup(%BTN{value: current_value, right: nil}, value) when current_value < value,
          do: nil
        
        defp do_lookup(%BTN{value: current_value, left: left}, value) when current_value > value do
          do_lookup(left, value)
        end
        
        defp do_lookup(%BTN{value: current_value, right: right}, value) when current_value < value do
          do_lookup(right, value)
        end
        ```
        
        As you can see here, we traverse the tree, deciding if we go to the left node or the right node. This creates a $log(n)$ time complexity, where for each node, you cut more than half of the tree during searching.
        
    - $O(n)$
        
        ```elixir
        def print_all_elements(elements) do
          Enum.map(elements, &IO.inspect/1) # O(n)
        end
        
        def print_all_elements(elements) do
        	for element <- elements do
            IO.inspect(element) # O(n) 
        	end
        end
        ```
        
        In O(n) we need to go through the entire list. If the size of elements increases, those functions will take a longer time to finish.
        
    - $O(n^2)$
        
        ```elixir
        def pairs_of_elements(elements) do
          Enum.map(elements, fn x ->
        	  Enum.map(elements, fn y ->
        	    {x, y} # O(n^2)
            end)
          end)
        end
        ```
        
        The above function generate pairs of the elements. For [1, 2] it will generate [{1, 1}, {1, 2}, {2, 1}, {2, 2}]. We have an $O(n^2)$ because it has a nested iterations. $O(n)$ inside a $O(n)$.
        
    - What causes Time in a function:
        - Operations `+ - \ * /`
        - Comparisons `< > <= >= != == !== ===`
        - Looping `for, Enum.map`
        - Outside Function call `function()`
3. Space Complexity
    
    How much space will it cost to run a code.
    In a machine, the amount of memory and the time of the CPU are limited. We need to share these resources with other processes.
    
    - $O(1)$
        
        ```elixir
        def return_first_element(elements) do
          first_element = List.first(elements) # O(1)
        end
        ```
        
        we are creating only one variable no matter how many elements we have.
        
    - $O(n)$
        
        ```elixir
        def print_all_elements(elements) do
        	for element <- elements do
            power = {element, element * element} # O(n)
        	end
        end
        ```
        
        In O(n) we are creating an variable for the same amount of elements.
        
    - $O(2^n)$
        
        ```elixir
        @spec fibonacci(integer()) :: integer()
        def fibonacci(0), do: 0
        def fibonacci(1), do: 1
        
        def fibonacci(n) do
        	fibonacci(n-1) + fibonacci(n-2)
        end
        ```
        
        Fibonacci Calls:
        fibonacci(5)
        |____ fibonacci(4)
        |     |____ fibonacci(3)
        |     |     |____ fibonacci(2)
        |     |     |     |____ fibonacci(1)
        |     |     |     |____ fibonacci(0)
        |     |     |____ fibonacci(1)
        |     |____ fibonacci(2)
        |           |____ fibonacci(1)
        |           |____ fibonacci(0)
        |____ fibonacci(3)
        |     |____ fibonacci(2)
        |     |     |____ fibonacci(1)
        |     |     |____ fibonacci(0)
        |     |____ fibonacci(1)
        
        In the above graph, each indentation level represents a recursive call to the Fibonacci function. As you can see, for each recursive call to calculate Fibonacci(n), it branches into two additional recursive calls to calculate Fibonacci(n-1) and Fibonacci(n-2), except for the base cases Fibonacci(0) and Fibonacci(1). This branching behavior leads to an exponential growth in the number of function calls, where for each value of n, it will take approximately 2^n calls to the function.
        
        This could cause a stack overflow or the maximum number of stack calls to be reached, causing your program to exit. To solve this problem, you could use tail-call optimization.
        
    - What causes Time in a function:
        - Variables `x = 1`
        - Data Structures `[] {} %{}`
        - Function Call, expect for tail-call recursions.
        - Allocations

In some cases we want that our programs to run as faster as possible. Sometimes we are worried about memory consumption, even if it takes more time to run. And sometimes we only look to readability. It depends but this three makes the pillars for a good code.

## How can we calculate Big O?

- Rule 1: Always Worst Case
    
    ```elixir
    def calculate_mean(elements) do
      sum_of_elements = sum_elements(elements) # O(n)
    	qty_of_elements = length(elements) # O(1)
      
    	sum_of_elements / qty_of_elements # O(1)
    end
    ```
    
    we have a sum of `O(n), O(1), O(1)`. Even if we have `O(1)` cases, the worst case is an `O(n)`. So the time complexity is `O(n)`.
    

---

- Rule 2: Remove Constants
    
    ```elixir
    def calculate_mean(elements) do
      sum_of_elements = sum_elements(elements) # O(n)
    	sum_of_elements_2 = sum_elements(elements) # O(n)
    	qty_of_elements = length(elements) # O(1)
      
    	(sum_of_elements + sum_of_elements_2) / qty_of_elements # O(1)
    end
    ```
    
    Here we have **`O(n + n + 1 + 1)`** or simply **`O(2n + 2)`**. The term **`2n`** increases as the number of elements increases, it means that it is linear. So we can just remove the constants, **`O(n + 1)`** which by Rule 1 is an **`O(n)`**.
    
    Even if you have **`O(n/2), O(5n/7), O(1000n)`**, it's still linear, drop the constant, **`O(n)`**.
    

---

- Rule 3:
    - Different inputs should have different variables: `O(n + m)`.
        
        ```elixir
        def sum_values_of_two_lists(list_1, list_2) do
        	# O(n)
        	sum_of_list_1 = Enum.reduce(list_1, 0, fn element, acc -> element + acc end)
        
        	# O(m)
        	sum_of_list_2 = Enum.reduce(list_2, 0, fn element, acc -> element + acc end)
        
        	# O(1)
        	sum_of_list_1 + sum_of_list_2
        end
        ```
        
        We traverse between those two lists. `O(n + m + 1)`. The big O can be written as `O(n + m)`.
        
        If `n = m` it will be `O(n)`.
        
    - M and N arrays nested would be: `O(m * n)`.
        
        ```elixir
        def nested_loop_function(list_1, list_2) do
        	Enum.map(list_1, fn list_1_element ->
        		Enum.map(list_2, fn list_2_element ->
        			list_1_element + list_2_element
        		end)
        	end)
        end
        ```
        
        We traversed between those two nested lists. `O(n * m)`. The big O can be written as `O(n * m)`.
        
        If `n = m` it will be $O(n^2)$
        

---

- Rule 4: Drop Non-dominant terms
    
    Imagine if you have calculated the Big O of some funcion, and get the following `O(n/2 + (n^2)/1000 + 115)`.
    As you can see for big values of n, the term $n^2$ increases more than n. even if it’s $n^2/1000$.
    
    In this cases we drop the non dominant terms. $O(n^2/1000)$ turns into $O(n^2)$.
    
    You can prove that using limits.
