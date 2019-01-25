/***************************************************************************
 *
 * This file is provided under a dual BSD/GPLv2 license.  When using or
 *   redistributing this file, you may do so under either license.
 * 
 *   GPL LICENSE SUMMARY
 * 
 *   Copyright(c) 2007-2018 Intel Corporation. All rights reserved.
 * 
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of version 2 of the GNU General Public License as
 *   published by the Free Software Foundation.
 * 
 *   This program is distributed in the hope that it will be useful, but
 *   WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *   General Public License for more details.
 * 
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
 *   The full GNU General Public License is included in this distribution
 *   in the file called LICENSE.GPL.
 * 
 *   Contact Information:
 *   Intel Corporation
 * 
 *   BSD LICENSE
 * 
 *   Copyright(c) 2007-2018 Intel Corporation. All rights reserved.
 *   All rights reserved.
 * 
 *   Redistribution and use in source and binary forms, with or without
 *   modification, are permitted provided that the following conditions
 *   are met:
 * 
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in
 *       the documentation and/or other materials provided with the
 *       distribution.
 *     * Neither the name of Intel Corporation nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 * 
 *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * 
 *  version: QAT1.7.L.4.3.0-00033
 *
 ***************************************************************************/

/*
 *****************************************************************************
 * Doxygen group definitions
 ****************************************************************************/

/**
 *****************************************************************************
 * @file icp_bnp_buffer_desc.h
 *
 * @defgroup icp_BufferDesc Buffer descriptor for LAC
 *
 * @ingroup LacCommon
 *
 * @description
 *      This file contains details of the hardware buffer descriptors used to
 *      communicate with the QAT.
 *
 *****************************************************************************/
#ifndef ICP_BNP_BUFFER_DESC_H
#define ICP_BNP_BUFFER_DESC_H

#include "icp_buffer_desc.h"
#include "icp_qat_fw_comp.h"

/**
 *****************************************************************************
 * @ingroup icp_BufferDesc
 *      Single Job descriptor entry pointed by the pointer in the list of opdata
 *
 * @description
 *      A QAT friendly buffer descriptor for Batch and Pack functionality.
 *      All buffer descriptor described in this structure are physical
 *      and are 64 bit wide.
 *      This structure is part of the icp_buffer_list_desc_t structure.
 *
 *****************************************************************************/
typedef struct icp_bnp_opdata_desc_s
{
    icp_qat_fw_comp_bnp_skip_info_t src_bnp_skip_info;
    /**< Optional skip regions in the input buffers */
    icp_qat_fw_comp_bnp_skip_info_t dst_bnp_skip_info;
    /**< Optional skip regions in the output buffers */
} icp_bnp_opdata_desc_t;

/**
 *****************************************************************************
 * @ingroup icp_BufferDesc
 *      Buffer descriptors for FlatBuffers - used in communications with
 *      the QAT.
 *
 * @description
 *      A QAT friendly buffer descriptor for Batch and Pack operations.
 *      All buffer descriptor described in this structure are physical
 *      and are 64 bit wide.
 *
 *****************************************************************************/
typedef struct icp_bnp_buffer_list_desc_s
{
    icp_qat_fw_comp_bnp_op_data_t bnpOpData;
    icp_qat_fw_comp_bnp_out_tbl_entry_t bnpOutTable;
    Cpa32U reserved1;
    Cpa32U reserved2;
    icp_buffer_list_desc_t bufferListDesc;
} icp_bnp_buffer_list_desc_t;

#endif /* ICP_BNP_BUFFER_DESC_H */
