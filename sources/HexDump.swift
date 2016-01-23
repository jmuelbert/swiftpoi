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

///
/// dump data in hexadecimal format
///
/// ported to swift
/// 2016 by Jürgen Mülbert
public class HexDump {
    
    public static let EOL = "\n"
    
    /// all static methods, so no need for a public constructor
    private func HexDump() { }
    
    /**
        dump an array of bytes to an OutputStream

        - Parameters 
            - data the byte array to be dumped
            - offset its offset, whatever that might mean
            - stream the OutputStream to which the data is to be
                    written
            - index initial index into the byte array
            - length number of characters to output

        - Throws: IOException is thrown if anything goes wrong writing
                    the data to stream
        - Throws: ArrayIndexOutOfBoundsException if the index is
                    outside the data array's bounds
        - Throws: IllegalArgumentException if the output stream is
                null
    */
    public static func dump(data: String, offset: Int,
        stream: String, index: Int, length: Int) {
            if (stream.isEmpty) {
                NSException.init(name: "IllegalArgumentException",
                    reason: "connot write to nullstream",
                    userInfo: nil
                    ).raise()
            }
            
            do {
                try data.writeToFile(stream, atomically: false, encoding:   NSASCIIStringEncoding)
            }
            catch { /* error handling here */
                NSException.init(name: "FileException",
                    reason: "The file is unreadable",
                    userInfo: nil
                    ).raise()
            }
    }
    
    /**
        dump an array of bytes to an OutputStream
    
        - Parameters
            - data the byte array to be dumped
            - offset its offset, whatever that might mean
            - stream the OutputStream to which the data is to be
                written
            - index initial index into the byte array

        - Throws: IOException is thrown if anything goes wrong writing
                the data to stream
        - Throws: ArrayIndexOutOfBoundsException if the index is
                outside the data array's bounds
        - Throws: IllegalArgumentException if the output stream is
                    null
    */
    public static func dump(data: String, offset: Int, stream: String, index: Int) {
        dump(data, offset:offset, stream:stream, index:Int.max)
    }
    
    
    //
    // dump an array of bytes to a String
    //
    // @param data the byte array to be dumped
    // @param offset its offset, whatever that might mean
    // @param index initial index into the byte array
    //
    // @exception ArrayIndexOutOfBoundsException if the index is
    //            outside the data array's bounds
    // @return output string
    //
    public static func dump(data: String, offset: Int, index: Int) -> String {
        return dump(data, offset:offset, index:index, length: Int.max);
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
    public static func dump(data: String, offset:Int, index: Int, length: Int) ->String {
        
        if (data.isEmpty) {
            return "No Data" + EOL
        }
        
        let data_length:Int = (length == Int.max || length < 0 ||  index+length < 0)
            ? data.lengthOfBytesUsingEncoding(NSASCIIStringEncoding)
            : min(data.lengthOfBytesUsingEncoding(NSASCIIStringEncoding), index+length)
        
        if ((index < 0) || (index >= data.lengthOfBytesUsingEncoding(NSASCIIStringEncoding))) {
            let errorString: String = "illegal index: \(data.lengthOfBytesUsingEncoding(NSASCIIStringEncoding)) into array of length"
            NSException.init(name: "ArrayIndexOutOfBounds",
                reason: errorString,
                userInfo: nil
                ).raise()
            
        }
        
        var display_offset: Int = offset + index
        var dataBuffer = [UInt8](data.utf8)
        var stringBuffer: String = String()
        
        for (var j:Int = index; j < data_length; j += 16) {
            var chars_read: Int = data_length - j
            
            if (chars_read > 16) {
                chars_read = 16
            }
            
            stringBuffer.appendContentsOf(String(format: "%08x", display_offset))
            for (var k:Int = 0; k < 16; k++) {
                if (k < chars_read) {
                    stringBuffer.appendContentsOf(" ")
                    let addString = NSString(format: "%02x", dataBuffer[k + j])
                    stringBuffer.appendContentsOf(addString as String)
                } else {
                    stringBuffer.appendContentsOf("   ")
                }
            }
            stringBuffer.appendContentsOf(" ")
            for (var k:Int = 0; k < chars_read; k++) {
                let char = NSString(format: "%c", dataBuffer[k+j])
                stringBuffer.appendContentsOf(char as String)
            }
            stringBuffer.appendContentsOf(EOL)
            display_offset += chars_read
        }
        return stringBuffer
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
        var fileContent: String?
        var pointerToUint:UnsafeMutablePointer<UInt>!
        pointerToUint = UnsafeMutablePointer<UInt>.alloc(1)
        if (bytesToDump == -1) {
            do {
                fileContent = try String(contentsOfFile: inFile, encoding: NSUTF8StringEncoding)
                try fileContent!.writeToFile(outFile, atomically: false, encoding: NSUTF8StringEncoding)
                //                dump(fileContent!, offset:0, stream:outFile, index:start, length:fileContent!.length)
            }
            catch { /* error handling here */
                NSException.init(name: "FileException",
                    reason: "The file is unreadable",
                    userInfo: nil
                    ).raise()
            }
        } else {
            do {
                //                buf = try NSData(contentsOfFile: inFile)
                var outBytes: NSData = NSData(bytesNoCopy: pointerToUint, length: bytesToDump, freeWhenDone: true)
                outBytes.writeToFile(outFile, atomically: false)
                //               dump(outBytes, offset:0, stream:outFile, index:start, length:outBytes.length)
            }
            catch { /* error handling here */
                NSException.init(name: "FileException",
                    reason: "The file is unreadable",
                    userInfo: nil
                    ).raise()
            }
            
        }
        
    }
    
    
    
    // TODO ----------------------------------------------------
    // TODO Make this
    // TODO ----------------------------------------------------
    // public static func toAscii(dataB: UInt16) -> UInt16  {
    //    let controlCharSet = NSCharacterSet.controlCharacterSet()
    //    let printableCharSet = NSCharacterSet.alphanumericCharacterSet()
    //    var charB: UInt16 =  (dataB & 0xFF)
    //    if (controlCharSet.characterIsMember(dataB)) {
    //        charB =
    //    } else if (!printableCharSet.characterIsMember(dataB))  {
    //        charB = (UInt16) "."
    //    }
    //    return dataB
    // }
    
    /**
        Converts the parameter to a hex value.

        Parameter value     The value to convert
        Return          The result right padded with 0
    */
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