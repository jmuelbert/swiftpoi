// ====================================================================
// Licensed to the Apache Software Foundation (ASF) under one or more
// contributor license agreements.  See the NOTICE file distributed with
// this work for additional information regarding copyright ownership.
// The ASF licenses this file to You under the Apache License, Version 2.0
// (the "License"); you may not use this file except in compliance with
// the License.  You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ==================================================================== */
//

import Foundation

//
// dump data in hexadecimal format
//

public class HexDump {
    
    // all static methods, so no need for a public constructor
    private func HexDump() { }

    //
    // dump an array of bytes to an OutputStream
    //
    // @param data the byte array to be dumped
    // @param offset its offset, whatever that might mean
    // @param stream the OutputStream to which the data is to be
    //              written
    // @param index initial index into the byte array
    // @param length number of characters to output
    //
    // @exception IOException is thrown if anything goes wrong writing
    //            the data to stream
    // @exception ArrayIndexOutOfBoundsException if the index is
    //            outside the data array's bounds
    // @exception IllegalArgumentException if the output stream is
    //            null
    //
    public static func dump(data: [Int], offset: Int,
        stream: NSOutputStream, index: Int, length: Int) {
            if (stream.isEqual(nil)) {
                NSException.init(name: "IllegalArgumentException",
                                       reason: "connot write to nullstream",
                    userInfo: nil
                ).raise()
            }
    }
    
    //
    // dump an array of bytes to an OutputStream
    //
    // @param data the byte array to be dumped
    // @param offset its offset, whatever that might mean
    // @param stream the OutputStream to which the data is to be
    //                written
    // @param index initial index into the byte array
    //
    // @exception IOException is thrown if anything goes wrong writing
    //            the data to stream
    // @exception ArrayIndexOutOfBoundsException if the index is
    //            outside the data array's bounds
    // @exception IllegalArgumentException if the output stream is
    //            null
    //
    public static func dump(data: [Int], offset: Int, stream: NSOutputStream, index: Int) {
        dump(data, offset:offset, stream:stream, index:Int.max)
    }
    
    //
    // dump an array of bytes to a String
    //
    // @param data the byte array to be dumped
    // @param offset its offset, whatever that might mean
    // @param index initial index into the byte array
    // @param length number of characters to output
    //
    // @exception ArrayIndexOutOfBoundsException if the index is
    //            outside the data array's bounds
    // @return output string
    //
    public static func dump(data: [Int], offset:Int, index: Int, length: Int) ->String {
        let space: Character = " "
        let EOL: Character = "\n"
        
        if (data.isEmpty || data.count == 0) {
            return "No Data\n"
        }
        
        let data_length:Int = (length == Int.max || length < 0 ||  index+length < 0)
            ? data.count
        : min(data.count, index+length)
        
        if ((index < 0) || (index >= data.count)) {
            let errorString: String = "illegal index: \(data.count) into array of length"
            NSException.init(name: "ArrayIndexOutOfBounds",
                reason: errorString,
                userInfo: nil
            ).raise()

        }
        
        var display_offset: Int = offset + index
        var buffer: String
        
        for (var j:Int = index; j < data_length; j += 16) {
            var chars_read: Int = data_length - j
            
            if (chars_read > 16) {
                chars_read = 16
            }
        }
      return buffer
    }
}