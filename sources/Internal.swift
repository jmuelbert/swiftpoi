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
//
//  Internal.swift
//  swiftpoi
//
//  Created by Jürgen Mülbert on 06.01.16.
//  Copyright © 2016 Jürgen Mülbert. All rights reserved.
//

import Foundation

//
// Program elements annotated &#64;Internal are intended for
// POI internal use only. Such elements are not public by design
// and likely to be removed in future versions of POI  or access
// to such elements will be changed from 'public' to 'default' or less.
//
// @author Yegor Kozlov
// @since POI-3.6
//
// Ported to swift by
// @author Jürgen Mülbert

public protocol Internal {
    var value: String { get }
}