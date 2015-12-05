//-------------------------------
// Data Memory Test
//-------------------------------

module testDataMemory;

    reg                   clk;              // Clock (Positive Edge Triggered)

    reg [1-1:0] [31:0]    dataIn_1core;     // Data to write
    reg [1-1:0] [31:0]    address_1core;    // Address to read/write
    reg [1-1:0]           writeEnable_1core;// Enable writing when high
    wire [1-1:0] [31:0]   dataOut_1core;    // Data being read

    reg [4-1:0] [31:0]    dataIn_4core;     // Data to write
    reg [4-1:0] [31:0]    address_4core;    // Address to read/write
    reg [4-1:0]           writeEnable_4core;// Enable writing when high
    wire [4-1:0] [31:0]   dataOut_4core;    // Data being read

    // Data memory for 1 core
    datamemory #(.cores(1)) dut1 (  .clk(clk),
                                    .dataIn(dataIn_1core),
                                    .address(address_1core),
                                    .writeEnable(writeEnable_1core),
                                    .dataOut(dataOut_1core));

    // Data memory for 4 core
    datamemory #(.cores(4)) dut4 (  .clk(clk),
                                    .dataIn(dataIn_4core),
                                    .address(address_4core),
                                    .writeEnable(writeEnable_4core),
                                    .dataOut(dataOut_4core));

    initial clk = 0;
    always #1 clk = !clk;
    reg dutPass;
    reg testFlag;

    initial begin
        $dumpfile("datamemory.t.vcd");
        $dumpvars(0, testDataMemory);
        dutPass = 1;

        // 1 core tests
        $display("Testing 1-Core Data Memory...");

        // Test Case 1
        // test if when write enable is high,
        // the data read is the data written
        writeEnable_1core = 1'b1;
        address_1core = 32'b01111;
        dataIn_1core = 32'b10101;
        #2;
        if (dataOut_1core !== dataIn_1core) begin
            $display("[Test 1] Unexpected read data from %b", address_1core);
            $display("[Test 1] Expected %b, got %b", dataIn_1core, dataOut_1core);
            dutPass = 0;
        end

        // Test Case 2
        // Try to write to an address but haha write enable is off so you cant
        writeEnable_1core = 1'b0;
        address_1core = 32'b01111;
        dataIn_1core = 32'b11111;
        #2;
        if (dataOut_1core === dataIn_1core) begin
            $display("[Test 2] Unexpected read data from %b", address_1core);
            $display("[Test 2] Expected %b, got %b", 32'b10101, dataOut_1core);
            dutPass = 0;
        end

        // Test Case 3
        // Write to an address and then go and write to another address
        // And then go back and read from the first address and it should
        // Still have held its value
        writeEnable_1core = 1'b1;
        address_1core = 32'b01001;
        dataIn_1core = 32'b1;
        #2;
        address_1core = 32'b01111;
        dataIn_1core = 32'b01101;
        #2;
        writeEnable_1core = 1'b0;
        address_1core = 32'b01001;
        #2
        if (dataOut_1core !== 32'b00001) begin
            $display("[Test 3] Unexpected read data from %b", address_1core);
            $display("[Test 3] Expected %b, got %b", 32'b00001, dataOut_1core);
            dutPass = 0;
        end

        // Test Case 4 and 5
        // Test simultaneous overwritting
        // Write to an address and then read it
        // and then write to it again and read it
        writeEnable_1core = 1'b1;
        address_1core = 32'b01011;
        dataIn_1core = 32'b00001;
        #2;
        if (dataOut_1core !== dataIn_1core) begin
            $display("[Test 4] Unexpected read data from %b", address_1core);
            $display("[Test 4] Expected %b, got %b", dataIn_1core, dataOut_1core);
            dutPass = 0;
        end
        dataIn_1core = 32'b11001;
        #2;
        if (dataOut_1core !== dataIn_1core) begin
            $display("[Test 5] Unexpected read data from %b", address_1core);
            $display("[Test 5] Expected %b, got %b", dataIn_1core, dataOut_1core);
            dutPass = 0;
        end

        if (dutPass) begin
            $display("Pass");
        end
        else begin
            $display("Fail");
        end

        // 4 core tests
        $display("Testing 4-Core Data Memory...");

        // Test Case 6
        // Write to 4 addresses simultaneously
        // Read from those 4 addresses
        // Expected Output:
        // Read the 4 written values
        writeEnable_4core[3:0] = 4'b1111;
        dataIn_4core[3] = 32'd87;
        dataIn_4core[2] = 32'd199;
        dataIn_4core[1] = 32'd100;
        dataIn_4core[0] = 32'd199;
        address_4core[3] = 5'd13;
        address_4core[2] = 5'd16;
        address_4core[1] = 5'd27;
        address_4core[0] = 5'd19;
        #2;
        for (int i = 3; i >= 0; i = i - 1) begin
            if (dataOut_4core[i] !== dataIn_4core[i]) begin
                $display("[Test 6_%d] Fail: Unexpected read data from %b", address_4core[i]);
                $display("[Test 6_%d] Fail: Expected %d, got %d", i, dataIn_4core[i], dataOut_4core[i]);
                dutPass = 0;
            end
        end

        // Test Case 7
        // Disable writing
        // read from the 4 addresses that were written to in the above test case
        // This tests data persistence, making sure the addresses maintain their values
        // Expected Output:
        // Read the 4 written values
        writeEnable_4core[3:0] = 4'b0000;
        dataIn_4core[3] = 32'd256;
        dataIn_4core[2] = 32'd129;
        dataIn_4core[1] = 32'd110;
        dataIn_4core[0] = 32'd189;
        #2;
        if (dataOut_4core[3] !== 32'd87) begin
            $display("[Test 7_1] Fail: Expected %d, got %d", 32'd87, dataOut_4core[3]);
            dutPass = 0;
        end
        if (dataOut_4core[2] !== 32'd199) begin
            $display("[Test 7_2] Fail: Expected %d, got %d", 32'd199, dataOut_4core[2]);
            dutPass = 0;
        end
        if (dataOut_4core[1] !== 32'd100) begin
            $display("[Test 7_3] Fail: Expected %d, got %d", 32'd100, dataOut_4core[1]);
            dutPass = 0;
        end
        if (dataOut_4core[0] !== 32'd199) begin
            $display("[Test 7_4] Fail: Expected %d, got %d", 32'd199, dataOut_4core[0]);
            dutPass = 0;
        end

        if (dutPass) begin
            $display("Pass");
        end
        else begin
            $display("Fail");
        end


        $finish;
    end

endmodule
