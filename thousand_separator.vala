class ThousandSeparator
{
    private const int MIN_DIGIT_SEPARATOR = 3;

    public string parse(double number) throws NumberParserError.OUT_OF_BOUNDS
    {
        if (number < 0 || number >= 2e34) {
            throw new NumberParserError.OUT_OF_BOUNDS("Number must be from 0 to 2e34 - 1");
        }

        string parsed_number = number.to_string();

        int number_length = parsed_number.char_count();
        if (number_length <= ThousandSeparator.MIN_DIGIT_SEPARATOR) 
        {
            return parsed_number;
        }

        string result = "";
        double separators_to_use = Math.ceil(number_length / ThousandSeparator.MIN_DIGIT_SEPARATOR);

        int curr_pos = 0;
        for(double i = separators_to_use; i >= 0; i--)
        {
            string separator = ".";
            if (result == "")
            {
                separator = "";
            }

            long end = number_length - ((long) i * 3);
            long start = curr_pos;
            result += separator + parsed_number[start : end];

            curr_pos = (int) end;
        }

        return result;
    }
}

struct SuccessTest 
{
    long test;
    string result;
}

struct ExceptionTest
{
    double test;
}

int main( string[] args )
{
    SuccessTest[] tests = {
        SuccessTest() { test=0, result="0" },
        SuccessTest() { test=1, result="1" },
        SuccessTest() { test=999, result="999" },
        SuccessTest() { test=1000, result="1.000" },
        SuccessTest() { test=10000, result="10.000" },
        SuccessTest() { test=100000, result="100.000" },
        SuccessTest() { test=1000000, result="1.000.000" },
        SuccessTest() { test=1000000000, result="1.000.000.000" },
    };

    ExceptionTest[] error_tests = {
        ExceptionTest() { test=-1 },
        ExceptionTest() { test=-1000 },
        ExceptionTest() { test=2e34 },
    };
    
    ThousandSeparator thousandSeparator = new ThousandSeparator();

    for (int i = 0; i < tests.length; i++)
    {
        long number = tests[i].test;
        string result = tests[i].result;

        string parsed_number = thousandSeparator.parse(number);
        
        bool correct = result == parsed_number;
        stdout.printf(@"Test number: $number\nOutput: $parsed_number\nResult: $correct\n\n");
    }
    
    for (int i = 0; i < error_tests.length; i++)
    {
        bool correct = true;
        double number = error_tests[i].test;

        try
        {
            stdout.printf(@"Test number: $number\n");
            thousandSeparator.parse(number);

            correct = false;
        } 
        catch(Error e)
        {
            stdout.printf(@"Exception: $(e.message)\n");
        }
        finally
        {
            stdout.printf(@"Result: $correct\n\n");
        }
    }

    return 0;
}