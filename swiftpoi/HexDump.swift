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
    public static func dump(data: NSData, offset: Int,
        stream: String, index: Int, length: Int) {
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
    public static func dump(data: NSData, offset: Int, stream: String, index: Int) {
        dump(data, offset:offset, stream:stream, index:Int.max)
    }
    
    
    //
    // Dumps <code>bytesToDump</code> bytes to an output stream.
    //
    // @param in          The stream to read from
    // @param out         The output stream
    // @param start       The index to use as the starting position for the left hand side label
    // @param bytesToDump The number of bytes to output.  Use -1 to read until the end of file.
    //
    public static func dump(inFile: String, outFile: String, start: Int, bytesToDump: Int) {
        var buf: NSData?
        var pointerToUint:UnsafeMutablePointer<UInt>!
        pointerToUint = UnsafeMutablePointer<UInt>.alloc(1)
        if (bytesToDump == -1) {
            do {
                buf = try NSData(contentsOfFile: inFile)
                buf!.writeToFile(outFile, atomically: false)
                dump(buf!, offset:0, stream:outFile, index:start, length:buf!.length)
            }
            catch { /* error handling here */
                NSException.init(name: "FileException",
                    reason: "The file is unreadable",
                    userInfo: nil
                    ).raise()
            }
        } else {
            do {
                buf = try NSData(contentsOfFile: inFile)
                var outBytes: NSData = NSData(bytesNoCopy: pointerToUint, length: bytesToDump, freeWhenDone: true)
                outBytes.writeToFile(outFile, atomically: false)
                dump(outBytes, offset:0, stream:outFile, index:start, length:outBytes.length)
            }
            catch { /* error handling here */
                NSException.init(name: "FileException",
                    reason: "The file is unreadable",
                    userInfo: nil
                    ).raise()
            }
            
        }
        
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
    public static func dump(data: NSData, offset:Int, index: Int, length: Int) ->String {
        let space: String = " "
        let EOL: String = "\n"
        var pointerToUint:UnsafeMutablePointer<UInt>!
        pointerToUint = UnsafeMutablePointer<UInt>.alloc(1)
        
        
        if (data.length == 0) {
            return "No Data" + EOL
        }
        
        let data_length:Int = (length == Int.max || length < 0 ||  index+length < 0)
            ? data.length
        : min(data.length, index+length)
        
        if ((index < 0) || (index >= data.length)) {
            let errorString: String = "illegal index: \(data.length) into array of length"
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
            buffer = buffer + (NSString(format: "%8", display_offset) as String) as String
            for (var k:Int = 0; k < 16; k++) {
                if (k < chars_read) {
                     // buffer = buffer + " " + (NSString(format: "%2", data.[k + j]) as String) as String
                }
            }
            
            
        }
        return "Noch nicht fertig"
    }
    
    
    // TODO ----------------------------------------------------
    // TODO Make this
    // TODO ----------------------------------------------------
    public static func toAscii(dataB: UInt16) -> UInt16  {
        let controlCharSet = NSCharacterSet.controlCharacterSet()
        let printableCharSet = NSCharacterSet.alphanumericCharacterSet()
        var charB: UInt16 =  (dataB & 0xFF)
        if (controlCharSet.characterIsMember(dataB)) {
            charB =
        } else if (!printableCharSet.characterIsMember(dataB))  {
            charB = (UInt16) "."
        }
        return dataB
    }
    
    //
    // Converts the parameter to a hex value.
    //
    // @param value     The value to convert
    // @return          The result right padded with 0
    //
    public static func toHex(value: Int8) ->String {
        let hexString: String =
        (NSString(format: "%4X", value ) as String) as String
        return hexString
        
    }

    
    //
    // Converts the parameter to a hex value.
    //
    // @param value     The value to convert
    // @return          The result right padded with 0
    //
    public static func toHex(value: Int16) ->String {
        let hexString: String =
        (NSString(format: "%8X", value ) as String) as String
        return hexString
        
    }

    
    //
    // Converts the parameter to a hex value.
    //
    // @param value     The value to convert
    // @return          The result right padded with 0
    // 
    public static func toHex(value: Int32) ->String {
        let hexString: String =
            (NSString(format: "%16X", value ) as String) as String
        return hexString
        
    }
    
    
    //
    // Converts the parameter to a hex value.
    //
    // @param value     The value to convert
    // @return          The result right padded with 0
    //
    public static func toHex(value: Int) ->String {
        let hexString: String =
        (NSString(format: "%32X", value) as String) as String
        return hexString
        
    }

    
  
    //
    // @return string of 16 (zero padded) uppercase hex chars and prefixed with '0x'
    //
    public static func longToHex(value: Int) -> String {
        let hexString: String = "0x" +
            (NSString(format: "%16X", value) as String) as String
        return hexString
        
    }
    //
    // @return string of 8 (zero padded) uppercase hex chars and prefixed with '0x'
    //
    public static func intToHex(value: Int) -> String {
        let hexString: String = "0x" +
            (NSString(format: "%8X", (value & 0xFFFFFFFF)) as String) as String
        return hexString
    }
    
    //
    // @return string of 4 (zero padded) uppercase hex chars and prefixed with '0x'
    //
    public static func shortToHex(value: Int) -> String {
        let hexString: String = "0x" +
            (NSString(format:"%4X", (value & 0xFFFF)) as String) as String
        return hexString
    }
    
    //
    // @return string of 2 (zero padded) uppercase hex chars and prefixed with '0x'
    //
    public static func byteToHex(value: Int) -> String {
        let hexString:String = "0x" + (NSString(format:"%2X", (value & 0xFF)) as String) as String
        return hexString
    }
}