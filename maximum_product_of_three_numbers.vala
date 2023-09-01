class MaxiumumProductOfThreeNumbers
{
    public void execute()
    {
        List<List<int>> examples = new List<List<int>>();
        examples.append(this.array_to_list({ 1, 2, 3 }));
        examples.append(this.array_to_list({ 1, 2, 3, 4 }));
        examples.append(this.array_to_list({ 4, 1, 3, 2 }));
        examples.append(this.array_to_list({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }));
        examples.append(this.array_to_list({ -1, -2, -3 }));
        examples.append(this.array_to_list({ -1, -2, -3, -4, -5 }));
        examples.append(this.array_to_list({ -1001, -2, -3, -4, -5 }));
        examples.append(this.array_to_list({ 1001, -2, -3, -4, -5 }));
        examples.append(this.array_to_list({ 1, -2, -3000, -4, -5 }));

        examples.foreach((example) => {
            try
            {
                int product = this.max_product(example);
                stdout.printf("Result: %i\n", product);
            }
            catch (Error e)
            {
                stdout.printf("Exception: %s\n", e.message);
            }
        });
    }

    private int max_product(List<int> nums) throws NumberParserError
    {
        if (nums.length() < 3 || nums.length() > 10e4)
        {
            throw new NumberParserError.OUT_OF_BOUNDS("Nums length must be equal or more than 3 and equal or less than 10e4");
        }

        nums.sort((a, b) => {
            if (a < b)
            {
                return -1;
            }
            else if (a > b)
            {
                return 1;
            }
            else {
                return 0;
            }
        });

        int max_product = 0;

        int start = 0;
        int end = 2;
        while (end < nums.length())
        {
            int[] sliced_nums = this.slice_list(nums, start, end);
            if (this.out_of_bounds(sliced_nums))
            {
                throw new NumberParserError.OUT_OF_BOUNDS("Numbers must be in the range of -1000 to 1000");
            }

            int product = this.internal_max_product(sliced_nums);
            if (start == 0)
            {
                max_product = product;
            }
            else if (product > max_product)
            {
                max_product = product;
            }

            start += 1;
            end += 1;
        }

        return max_product;
    }

    private int internal_max_product(int[] nums)
    {
        int product = 1;
        if (nums.length < 3)
        {
            return product;
        }

        for (int i = 0; i < nums.length; i++)
        {
            product *= nums[i];
        }

        return product;
    }

    private bool out_of_bounds(int[] triple)
    {
        bool is_out_of_bounds = false;

        for (int i = 0; i < triple.length; i++)
        {
            if (triple[i] < -1000 || triple[i] > 1000)
            {
                is_out_of_bounds = true;
            }
        }

        return is_out_of_bounds;
    }

    private List<int> array_to_list(int[] nums)
    {
        List<int> result = new List<int>();

        foreach (int num in nums)
        {
            result.append(num);
        }

        return result;
    }

    private int[] slice_list(List<int> nums, int start, int end)
    {
        if (end >= nums.length())
        {
            return new int[] {};
        }

        int length = (end + 1) - start;
        int[] sliced_list = new int[length];

        int curr_pos = 0;
        for (int i = start; i <= end; i++)
        {
            sliced_list[curr_pos] = nums.nth_data(i);
            curr_pos++;
        }

        return sliced_list;
    }
}

int main()
{
    MaxiumumProductOfThreeNumbers maxiumumProductOfThreeNumbers = new MaxiumumProductOfThreeNumbers();

    maxiumumProductOfThreeNumbers.execute();

    return 0;
}